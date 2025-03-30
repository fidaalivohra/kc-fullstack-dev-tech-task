<?php

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../models/Course.php';

function getCourses() {
    $db = new Database();
    $conn = $db->getConnection();

    $course = new Course($conn);
    $courses = $course->getAllCourses();

    http_response_code(200);
    echo json_encode($courses);

    $db->closeConnection();
}
