<?php

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../models/Category.php';

function getCategories() {
    $db = new Database();
    $conn = $db->getConnection();

    $category = new Category($conn);
    $categories = $category->getAllCategories();

    http_response_code(200);
    echo json_encode($categories);

    $db->closeConnection();
}
