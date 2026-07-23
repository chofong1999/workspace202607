from __future__ import annotations

import json
import re
import sys
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont


SOURCE = Path(sys.argv[1])
JSP = Path(sys.argv[2])
OUTPUT = Path(sys.argv[3])
QA_OUTPUT = Path(sys.argv[4])

CROP = (0, 325, 1872, 690)
FIRST_LINE = 76
LINE_TOP = 8
LINE_HEIGHT = 19
CELL_X = 75
CELL_WIDTH = 9
BG = (30, 31, 34)

COLORS = {
    "HTML": (47, 134, 255),
    "CSS": (166, 75, 222),
    "JSP 指令／註解": (255, 203, 0),
    "JSP Action": (255, 152, 0),
    "Java scriptlet": (255, 45, 85),
    "EL": (211, 72, 139),
    "JSTL": (80, 205, 58),
}


def ink(pixel: tuple[int, int, int]) -> bool:
    return max(abs(pixel[i] - BG[i]) for i in range(3)) >= 12


def line_y(line_no: int) -> int:
    return LINE_TOP + (line_no - FIRST_LINE) * LINE_HEIGHT


def line_ink_bbox(image: Image.Image, start: int, end: int) -> tuple[int, int, int, int]:
    pix = image.load()
    xs: list[int] = []
    ys: list[int] = []
    for line_no in range(start, end + 1):
        top = max(0, line_y(line_no))
        bottom = min(image.height, top + 17)
        for y in range(top, bottom):
            for x in range(CELL_X, 820):
                if ink(pix[x, y]):
                    xs.append(x)
                    ys.append(y)
    if not xs:
        raise RuntimeError(f"No code pixels found for lines {start}-{end}")
    return min(xs), min(ys), max(xs), max(ys)


def padded(box: tuple[int, int, int, int], px: int, py: int) -> tuple[int, int, int, int]:
    x1, y1, x2, y2 = box
    return x1 - px, y1 - py, x2 + px, y2 + py


def load_font(size: int) -> ImageFont.FreeTypeFont:
    return ImageFont.truetype(r"C:\Windows\Fonts\msjh.ttc", size=size)


source_full = Image.open(SOURCE).convert("RGB")
base = source_full.crop(CROP)
original = base.copy()
jsp_lines = JSP.read_text(encoding="utf-8").splitlines()

expressions: list[dict[str, object]] = []
for line_no in range(76, 94):
    line = jsp_lines[line_no - 1]
    for match in re.finditer(r"\$\{[^}]+\}", line):
        # Eclipse in this capture advances both ASCII and CJK by the same 9 px cell.
        x1 = CELL_X + match.start() * CELL_WIDTH
        x2 = CELL_X + match.end() * CELL_WIDTH - 1
        y1 = line_y(line_no)
        y2 = y1 + 16
        expressions.append({"line": line_no, "text": match.group(), "box": (x1, y1, x2, y2)})

pix = base.load()
original_pix = original.load()
pink = COLORS["EL"]
recolored_pixels = 0
for item in expressions:
    x1, y1, x2, y2 = item["box"]  # type: ignore[misc]
    for y in range(y1, y2 + 1):
        for x in range(x1, x2 + 1):
            p = original_pix[x, y]
            delta = max(abs(p[i] - BG[i]) for i in range(3))
            if delta < 12:
                continue
            # Recover glyph coverage from the original pixel, then change only hue.
            alpha = min(1.0, delta / 190.0)
            q = tuple(round(BG[i] + (pink[i] - BG[i]) * alpha) for i in range(3))
            pix[x, y] = q
            recolored_pixels += 1

draw = ImageDraw.Draw(base)

html_box = padded(line_ink_bbox(original, 76, 93), 6, 4)
action_box = padded(line_ink_bbox(original, 79, 79), 4, 3)
java_box = padded(line_ink_bbox(original, 81, 81), 4, 3)
jstl_box = padded(line_ink_bbox(original, 89, 91), 5, 4)

for box, color in (
    (html_box, COLORS["HTML"]),
    (action_box, COLORS["JSP Action"]),
    (java_box, COLORS["Java scriptlet"]),
    (jstl_box, COLORS["JSTL"]),
):
    draw.rectangle(box, outline=color, width=2)

el_ys = []
for item in expressions:
    x1, y1, x2, y2 = item["box"]  # type: ignore[misc]
    el_ys.extend((y1, y2))
bracket_x = 830
bracket_top = min(el_ys) - 2
bracket_bottom = max(el_ys) + 2
draw.line((bracket_x, bracket_top, bracket_x, bracket_bottom), fill=pink, width=2)
draw.line((bracket_x - 14, bracket_top, bracket_x, bracket_top), fill=pink, width=2)
draw.line((bracket_x - 14, bracket_bottom, bracket_x, bracket_bottom), fill=pink, width=2)

font = load_font(19)
legend_font = load_font(17)
box_fill = (10, 15, 23)


def callout(box: tuple[int, int, int, int], color: tuple[int, int, int], lines: list[str], anchor: tuple[int, int]) -> None:
    x1, y1, x2, y2 = box
    target = (x1, (y1 + y2) // 2)
    draw.line((anchor[0], anchor[1], target[0], target[1]), fill=color, width=2)
    draw.rounded_rectangle(box, radius=13, fill=box_fill, outline=color, width=2)
    ty = y1 + 8
    for text in lines:
        draw.text((x1 + 18, ty), text, font=font, fill=color)
        ty += 25


callout((860, 8, 1350, 66), COLORS["JSP Action"], ["JSP Action：jsp:useBean 建立 colors", "ArrayList 儲存在 page scope"], (action_box[2], (action_box[1] + action_box[3]) // 2))
callout((860, 75, 1350, 135), COLORS["Java scriptlet"], ["Java scriptlet：執行 colors.add()", "在伺服器端建立三筆顏色資料"], (java_box[2], (java_box[1] + java_box[3]) // 2))
callout((860, 144, 1350, 204), COLORS["HTML"], ["HTML：section、段落與清單", "安排內容結構與顯示位置"], (html_box[2], (html_box[1] + html_box[3]) // 2))
el_callout = (860, 213, 1350, 283)
el_center_y = (el_callout[1] + el_callout[3]) // 2
el_connector_start = (bracket_x, el_center_y)
el_connector_end = (el_callout[0], el_center_y)
callout(el_callout, pink, ["EL：讀取清單與迴圈資料", "colors[n]、size()、status.index、color"], el_connector_start)
callout((860, 292, 1350, 352), COLORS["JSTL"], ["JSTL：c:forEach 逐筆取出 color", "varStatus 提供目前索引"], (jstl_box[2], (jstl_box[1] + jstl_box[3]) // 2))

# Fixed seven-item legend.
legend = (1390, 154, 1850, 352)
draw.rounded_rectangle(legend, radius=13, fill=box_fill, outline=(190, 198, 210), width=2)
legend_items = ["HTML", "JSP Action", "CSS", "Java scriptlet", "JSP 指令／註解", "EL", "JSTL"]
positions = [(1410, 177), (1618, 177), (1410, 219), (1618, 219), (1410, 261), (1618, 261), (1410, 303)]
for label, (x, y) in zip(legend_items, positions):
    color = COLORS[label]
    draw.rectangle((x, y, x + 20, y + 20), fill=color)
    draw.text((x + 31, y - 1), label, font=legend_font, fill=(205, 210, 218))

# Quantitative checks: exact EL glyph pixels changed; all other original glyph pixels untouched.
out_pix = base.load()
el_mask: set[tuple[int, int]] = set()
for item in expressions:
    x1, y1, x2, y2 = item["box"]  # type: ignore[misc]
    for y in range(y1, y2 + 1):
        for x in range(x1, x2 + 1):
            if ink(original_pix[x, y]):
                el_mask.add((x, y))

unchanged_el = sum(1 for x, y in el_mask if out_pix[x, y] == original_pix[x, y])
changed_non_el_glyph = 0
for y in range(base.height):
    for x in range(CELL_X, 820):
        if (x, y) not in el_mask and ink(original_pix[x, y]) and out_pix[x, y] != original_pix[x, y]:
            changed_non_el_glyph += 1

el_connector_is_horizontal = el_connector_start[1] == el_connector_end[1]
status = "PASS" if len(expressions) == 7 and unchanged_el == 0 and changed_non_el_glyph == 0 and el_connector_is_horizontal else "FAIL"
OUTPUT.parent.mkdir(parents=True, exist_ok=True)
base.save(OUTPUT, format="PNG", optimize=True)

qa = {
    "status": status,
    "sop": "1.9-user-requested-recolor-exception",
    "source": str(SOURCE),
    "crop": list(CROP),
    "output": str(OUTPUT),
    "el_expression_count": len(expressions),
    "el_expressions": expressions,
    "recolored_glyph_pixels": recolored_pixels,
    "unchanged_el_glyph_pixels": unchanged_el,
    "changed_non_el_original_glyph_pixels": changed_non_el_glyph,
    "el_connector_is_horizontal": el_connector_is_horizontal,
    "notes": [
        "Produced directly from the raw screenshot, not from a prior annotated image.",
        "EL hue changed only on original glyph pixels; no text was retyped.",
        "Pending user visual confirmation before documenting as SOP technique.",
    ],
}
QA_OUTPUT.parent.mkdir(parents=True, exist_ok=True)
QA_OUTPUT.write_text(json.dumps(qa, ensure_ascii=False, indent=2), encoding="utf-8")
print(json.dumps(qa, ensure_ascii=False, indent=2))
if status != "PASS":
    raise SystemExit(2)
