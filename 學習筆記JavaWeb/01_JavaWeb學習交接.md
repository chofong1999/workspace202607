# Java Web／JSP／EL／JSTL 學習交接

## 一、環境

- 作業系統：Windows 10
- IDE：Eclipse IDE（2026-06 系列／畫面顯示 workspace202607）
- JDK：21.0.10
- Tomcat：10.1.25
- Web 技術命名空間：Jakarta（例如 `jakarta.servlet.*`、`jakarta.tags.*`）
- 工作區：`C:\workspace202607`
- Tomcat 另有安裝位置：`C:\apache-tomcat-10.1.25`

注意：使用者有時從 Eclipse 啟動 Tomcat，有時也曾直接執行 Tomcat 的 `startup`。回答前要先確認現在是哪一個 Tomcat instance 與 `CATALINA_BASE`，避免修改錯誤的 `tomcat-users.xml` 或 Server 設定。

## 二、使用者的學習需求與溝通方式

使用者不是只想複製答案，而是在建立固定規則。解釋時應：

- 明確指出目前是哪一層：HTML、HTTP、Java、JSP scriptlet、EL 或 JSTL。
- 將「變數名稱」、「屬性名稱」、「物件屬性」分開解釋。
- 遇到隱性型態轉換，要說明觸發轉換的運算子及轉換方向。
- 最好提供一個最小範例和實際輸出。
- 不要把關閉驗證器當成真正修復；若是 IDE false positive，要提出證據與根因範圍。
- 使用者會實際測試並指出矛盾；被指出時應直接承認和修正。

## 三、目前專案與練習內容

### 主要專案

目前主要看 `mvweb0715`，內容包含：

- Servlet
- JSP
- HTML 表單
- JavaBean（例如 `model.User`、`User2`）
- JSP EL
- JSTL Core／Formatting／Functions

曾出現或正在使用的檔案名稱包括：

- `price.html`、`price.jsp`
- `compare.html`、`comresult.jsp`
- `userform.html`、`userform.jsp`
- `userbean.jsp`
- `el_object.jsp`
- `el-jstl.jsp`

接手時請以磁碟上的實際檔案為準，不要依這份清單推測內容。

## 四、已釐清的核心觀念

### 1. HTTP 表單送來的參數本質是字串

HTML：

```html
<input name="num1" value="13">
```

Java：

```java
String raw = request.getParameter("num1");
int num1 = Integer.parseInt(raw);
```

EL 的 `${param.num1}` 取得的也是 request parameter 字串。EL 遇到算術或關係運算時，可能依運算規則進行型態強制轉換。不要說成「全看運氣」，但也不要用另一個隱性轉換去假裝避免隱性轉換。

使用者曾正確指出：`${param.num1 + 0}` 仍然是依靠 EL 的隱性數字轉換，因此不能稱為「明確型態轉換」。

在目前 Tomcat 10.1／Jakarta EL 環境中，下列寫法已由使用者實測可執行：

```jsp
${Integer.parseInt(param.num1)}
```

現代 Jakarta EL 支援呼叫可存取的 static method，且 `java.lang` 類別可直接使用。若要讓架構更清楚，仍可在 Servlet 中一次解析與驗證，再把 `Integer` 放進 request scope，交給 JSP 顯示。

### 2. 字串的 `+` 與數字運算不是同一件事

- Java 的 `"13" + "2"` 是字串串接，得到 `"132"`。
- Java 的 `Integer.parseInt("13") + Integer.parseInt("2")` 是加法，得到 `15`。
- EL 有自己的運算與 coercion 規則，不能直接套用 Java `+` 的全部直覺。

### 3. Java 的短路運算與 null

老師想表達的正確 Java 範例應是：

```java
String s1 = null;

boolean unsafe = s1.length() > 0 && s1 != null; // 執行時先 NPE
boolean safe   = s1 != null && s1.length() > 0; // 左側 false，右側不執行
```

如果寫成 `s1.length() && ...`，會先因為 `length()` 是 `int`、不是 `boolean` 而無法編譯。`s1 != null()` 或 `s1.length` 也都是語法錯誤。必須先把老師想說的概念和筆記中的語法錯誤分開。

跨語言對照：

- C++ 的 `std::string` 是值物件，不能設為 null；指標才可用 `nullptr`。
- 現代 C++：`std::string* p = nullptr;`，安全判斷為 `p != nullptr && !p->empty()`。
- 舊 Dev-C++／GCC 4.9 若未開 C++11，可能不認得 `nullptr`；這是編譯標準設定問題。
- Python 使用 `None` 與 `and`，例如 `s is not None and len(s) > 0`。

### 4. 四種 scope 與 pageContext

JSP 常見四個 attribute scope：

| Scope | Java 設定方式 | EL 明確讀取 | 大致生命週期 |
|---|---|---|---|
| page | `pageContext.setAttribute("user", u)` | `${pageScope.user}` | 目前 JSP 頁面 |
| request | `request.setAttribute("user", u)` | `${requestScope.user}` | 一次 request／forward |
| session | `session.setAttribute("user", u)` | `${sessionScope.user}` | 同一使用者 session |
| application | `application.setAttribute("user", u)` | `${applicationScope.user}` | 整個 Web 應用程式 |

```jsp
${user}
```

沒有指定 scope 時，EL 依序搜尋：page → request → session → application。

容易混淆的三件事：

- Java 中的 `pageContext`：JSP 提供的 `PageContext` 物件，可呼叫 `setAttribute()`。
- EL 中的 `${pageContext.request.requestURI}`：透過 EL implicit object `pageContext` 存取 JSP 環境物件。
- EL 中的 `${pageScope.user}`：page scope attribute 的 Map view。

它們名稱相似，但一個是 PageContext 物件，一個是 scope Map。

### 5. request parameter 與 attribute 不同

- `${param.name}`：HTML 表單或 URL 傳來的 request parameter。
- `${requestScope.name}`：伺服器程式用 `request.setAttribute("name", value)` 放入的 attribute。
- 兩者都掛在同一次 request 附近，但不是同一套資料。

### 6. HTML 的 id、name 與 JSP/JSTL 的 id、name、var

這些名稱沒有跨語言的統一意義，必須看「它是哪個標籤的屬性」。

HTML 表單：

```html
<label for="favoriteAnimal">動物</label>
<input id="favoriteAnimal" name="favoriteAnimal">
```

- HTML `id`：瀏覽器 DOM 身分；供 `<label for>`、CSS、JavaScript 使用；本身不負責送出。
- HTML `name`：表單送到伺服器時的 parameter key。

JSP JavaBean：

```jsp
<jsp:useBean id="userA" class="model.User" />
<jsp:setProperty name="userA" property="name" value="${param.name}" />
```

- `useBean id="userA"`：建立／尋找 Bean，並以 `userA` 這個名稱存入 scope。
- `setProperty name="userA"`：指定要操作名為 `userA` 的 Bean；它對應前面的 `id`。
- `property="name"`：Bean property，通常對應 `setName()`／`getName()`。

JSTL：

```jsp
<c:set var="fruits" value="..." />
```

- `var`：結果要儲存成哪個 scoped attribute 名稱。
- 未指定 `scope` 時，`c:set` 預設放在 page scope。
- 概念上近似 `pageContext.setAttribute("fruits", value)`。

### 7. `c:forEach` 的 var 與 varStatus

```jsp
<c:forEach var="fruit" items="${fruits}" varStatus="status">
    ${status.count}. ${fruit}
</c:forEach>
```

- `items="${fruits}"`：要迭代的集合。
- `var="fruit"`：每一輪把目前元素放入名為 `fruit` 的變數。
- `varStatus="status"`：每一輪把迴圈狀態物件放入名為 `status` 的變數。

常用狀態：

| EL | 意義 |
|---|---|
| `${status.index}` | 從 0 開始的索引 |
| `${status.count}` | 從 1 開始的輪次 |
| `${status.first}` | 是否第一輪 |
| `${status.last}` | 是否最後一輪 |
| `${status.current}` | 目前元素 |
| `${status.begin}` | 起點設定 |
| `${status.end}` | 終點設定 |
| `${status.step}` | 間隔設定 |

重要：`${status.count}` 只是讀取「現在第幾輪」，不是陣列索引操作，也不會控制 `${fruit}` 選哪個元素。

```jsp
2. ${fruit}
```

只會在每輪印固定的 `2.` 加上當輪水果。要直接取得第三個元素，使用：

```jsp
${fruits[2]}
```

如果只是顯示 1 起算編號，`${status.count}` 比 `${status.index + 1}` 更直接。

## 五、Eclipse／Tomcat 已知問題

### 1. Eclipse 對 `jakartaee_10.xsd` 的錯誤標記

曾在多個專案甚至新建專案看到：

```text
Referenced file contains errors
(...org.eclipse.jst.standard.schemas...jar!.../jakartaee_10.xsd)
```

特徵：

- 指向 Eclipse plugin 內建的 `jakartaee_10.xsd`。
- `Show Details` 視窗可能沒有實際子錯誤。
- 同一錯誤同時出現在專案 `web.xml`、Servers 下的 `web.xml`、新專案 `web.xml`。
- `web.xml` 本身的 UTF-8 宣告與 Jakarta EE 10 namespace/schemaLocation 看起來正確。
- Tomcat 可正常執行專案。

目前合理判定：Eclipse WTP/XML validator／schema catalog 的 false marker 或 plugin 相容性問題，不是 `web.xml` 內容拼字造成。不要再把 `myservlet` 的 spell-check 提示誤判為 XML schema error；URL pattern 可由開發者自行命名。

「關掉 validator」只能隱藏，不算根治。真正處理方向應是：確認 Eclipse/WTP build、plugin 版本、乾淨安裝、schema bundle 是否損壞或有已知 bug；但不要在沒有證據時宣稱只發生於某個單一版本。

### 2. EL list literal 被 Eclipse 樅線標紅，但 Tomcat 正常執行

目前程式類似：

```jsp
<c:set var="fruits" value="${['蘋果', '香蕉', '橘子', '葡萄', '西瓜']}" />
```

Eclipse 在 `${[...]}` 附近顯示紅色 marker，但 Tomcat/Jasper 已成功渲染完整水果清單。這表示 runtime 支援此 EL list literal，而 Eclipse 編輯器／validator 的語法支援落後或誤判。

若只是想避免 IDE marker，可改用例如：

```jsp
<c:set var="fruits" value="${fn:split('蘋果,香蕉,橘子,葡萄,西瓜', ',')}" />
```

但這是相容寫法，不代表原本 runtime 程式錯誤。

### 3. Console 紅字不一定是錯誤

Eclipse Console 中 Tomcat 的 INFO 訊息可能以紅色顯示。判斷時看 log level 與例外堆疊，不要只看字體顏色。

### 4. CSS 色碼旁的小色塊

CSS 中 `#ddd`、`white`、`rgba(...)` 旁出現顏色預覽，來自 Eclipse 的 Web/CSS language tooling（常見為 Wild Web Developer／LSP4E color decorator）。它不是程式碼中的奇怪字元。

## 六、Tomcat Manager 登入事件

曾開啟 `http://localhost:8080/manager/status` 得到 `403 Access Denied`。要分清楚：

- 401／登入框通常是帳號密碼驗證問題。
- 403 可能是角色不足、來源限制、CSRF、或修改了錯誤 Tomcat instance 的設定。
- Tomcat Manager HTML GUI 通常需要 `manager-gui` role。
- 修改 `tomcat-users.xml` 後必須停止並重新啟動正確的 Tomcat instance。
- 連續執行多次 `startup` 不會讓同一連接埠上的 Tomcat 重啟；已啟動時通常只會造成連接埠衝突或第二個 instance 啟動失敗。

若家裡不需要 Manager，不必為了執行一般 JSP 專案強制處理 Manager 登入。

## 七、Java 程式碼警告（不是編譯錯誤）

曾看到：

- `ArrayList`、`List` import 未使用：刪除未用 import 即可。
- Servlet 未宣告 `serialVersionUID`：可加入：

```java
private static final long serialVersionUID = 1L;
```

這些是 warning，和 `jakartaee_10.xsd` 的 XML Problem 不同。

## 八、接手後建議的下一步

1. 先打開 `mvweb0715/src/main/webapp/el-jstl.jsp`，確認目前實際程式內容。
2. 延續說明 `c:forEach`：`items`、`var`、`varStatus`、`begin/end/step`，最好讓使用者修改資料並預測輸出。
3. 接著整理 JSTL：
   - `<c:set>`：建立 scoped attribute
   - `<c:if>`：單一條件
   - `<c:choose>/<c:when>/<c:otherwise>`：多重條件
   - `<c:forEach>`：迭代
   - `<fmt:formatNumber>`：格式化
   - `fn:*`：字串／集合相關函式
4. 教學時持續把 `var`、HTML `name`、Bean property、scope attribute 分開。
5. 若要修改程式，先讓使用者知道會改哪個檔案與目的；不要一次重寫整個練習，避免失去學習脈絡。

## 九、給下一個 AI 的一句話摘要

這位使用者正在從 Java 基礎跨到 JSP／EL／JSTL，最容易卡住的不是語法本身，而是「相同名稱在不同層代表不同角色」以及「EL 的隱性型態轉換」。回答必須建立可驗證的規則，並尊重使用者親自執行得到的結果。
