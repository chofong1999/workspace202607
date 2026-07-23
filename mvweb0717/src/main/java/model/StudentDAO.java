// StudentDAO.java
package model;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

public class StudentDAO {
    private static final Map<Integer, Student> students = new ConcurrentHashMap<>();
    private static final AtomicInteger idGenerator = new AtomicInteger(1);
    
    static {
        students.put(1, new Student(1, "張小明", 20, "ming@example.com"));
        students.put(2, new Student(2, "李小華", 21, "hua@example.com"));
        idGenerator.set(3);
    }
    
    public List<Student> findAll() {
        return new ArrayList<>(students.values());
    }
    
    public Student findById(int id) {
        return students.get(id);
    }
    
    public void save(Student student) {
        if (student.getId() == 0) {
            student.setId(idGenerator.getAndIncrement());
        }
        students.put(student.getId(), student);
    }
    
    public boolean delete(int id) {
        return students.remove(id) != null;
    }
}
