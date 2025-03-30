<?php

class Category {
    private $conn;
    
    public function __construct($conn) {
        $this->conn = $conn;
    }

    public function getAllCategories() {
        $sql = "
            WITH RECURSIVE category_tree AS (
                -- Get all top-level categories
                SELECT id, name, parent_id, 1 AS depth FROM categories WHERE parent_id IS NULL
                UNION ALL
                -- Recursively get subcategories, keeping depth <= 4
                SELECT c.id, c.name, c.parent_id, ct.depth + 1
                FROM categories c
                JOIN category_tree ct ON c.parent_id = ct.id
                WHERE ct.depth < 4
            ),
            course_counts AS (
                -- Get count of courses for each category (including subcategories)
                SELECT ct.id, COUNT(c.id) AS total_course_count
                FROM category_tree ct
                LEFT JOIN courses c ON ct.id = c.category_id
                GROUP BY ct.id
            )
            -- Fetch categories with their total course count
            SELECT ct.id, ct.name, ct.parent_id, COALESCE(SUM(cc.total_course_count), 0) AS course_count
            FROM category_tree ct
            LEFT JOIN course_counts cc ON ct.id = cc.id OR ct.parent_id = cc.id
            GROUP BY ct.id, ct.name, ct.parent_id
            ORDER BY ct.depth
        ";

        $result = $this->conn->query($sql);

        $categories = [];
        while ($row = $result->fetch_assoc()) {
            $categories[$row['id']] = $row;
        }

        return $this->buildCategoryTree($categories);
    }

    private function buildCategoryTree($categories) {
        $tree = [];
        foreach ($categories as &$category) {
            if ($category['parent_id']) {
                $categories[$category['parent_id']]['children'][] = &$category;
            } else {
                $tree[] = &$category;
            }
        }
        return $tree;
    }
}
