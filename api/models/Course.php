<?php

class Course {
    private $conn;
    
    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function getAllCourses() {
        $categoryId = isset($_GET['category_id']) ? $_GET['category_id'] : null;
        $sql = "SELECT c.id, c.name, c.description, c.image_preview as preview, c.category_id,
                    COALESCE(root_category.name, parent3.name, parent2.name, parent1.name, self_category.name) AS main_category_name
                FROM courses c
                JOIN categories self_category ON c.category_id = self_category.id
                LEFT JOIN categories parent1 ON self_category.parent_id = parent1.id
                LEFT JOIN categories parent2 ON parent1.parent_id = parent2.id
                LEFT JOIN categories parent3 ON parent2.parent_id = parent3.id
                LEFT JOIN categories root_category ON parent3.parent_id IS NULL AND parent3.id IS NOT NULL";

        if ($categoryId) {
            $sql = "WITH RECURSIVE category_tree AS (
                        SELECT id FROM categories WHERE id = ?
                        UNION ALL
                        SELECT c.id FROM categories c
                        INNER JOIN category_tree ct ON c.parent_id = ct.id
                    )
                    $sql
                    WHERE c.category_id IN (SELECT id FROM category_tree)";
        }

        if ($categoryId) {
            $stmt = $this->conn->prepare($sql);
            $stmt->bind_param("s", $categoryId);
        } else {
            $stmt = $this->conn->prepare($sql);
        }

        $stmt->execute();
        $result = $stmt->get_result();

        $courses = [];
        while ($row = $result->fetch_assoc()) {
            $courses[] = $row;
        }
        return $courses;
    }
}
