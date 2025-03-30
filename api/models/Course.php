<?php

class Course {
    private $conn;
    
    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function getAllCourses() {
        $sql = "SELECT c.id, c.name, c.description, c.image_preview as preview, c.category_id,
                    COALESCE(root_category.name, parent3.name, parent2.name, parent1.name, self_category.name) AS main_category_name
                FROM courses c
                JOIN categories self_category ON c.category_id = self_category.id
                LEFT JOIN categories parent1 ON self_category.parent_id = parent1.id
                LEFT JOIN categories parent2 ON parent1.parent_id = parent2.id
                LEFT JOIN categories parent3 ON parent2.parent_id = parent3.id
                LEFT JOIN categories root_category ON parent3.parent_id IS NULL AND parent3.id IS NOT NULL
                GROUP BY c.id";
                
        $result = $this->conn->query($sql);

        $courses = [];
        while ($row = $result->fetch_assoc()) {
            $courses[] = $row;
        }
        return $courses;
    }
}
