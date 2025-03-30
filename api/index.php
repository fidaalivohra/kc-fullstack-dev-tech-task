<?php
CONST BASE_URL = "http://cc.localhost/kc-fullstack-dev-tech-task/";
CONST BASE_API_URL = "http://cc.localhost/kc-fullstack-dev-tech-task/api/";
header("Content-Type: application/json");

$request_uri = str_replace("/kc-fullstack-dev-tech-task", "",explode("?", $_SERVER["REQUEST_URI"], 2)[0]);

require_once __DIR__ . '../routes/categories.php';
require_once __DIR__ . '../routes/courses.php';

switch ($request_uri) {
    case "/api/categories":
        getCategories();
        break;
    case "/api/courses":
        getCourses();
        break;
    default:
        http_response_code(404);
        echo json_encode(["error" => "Endpoint not found"]);
        break;
}
