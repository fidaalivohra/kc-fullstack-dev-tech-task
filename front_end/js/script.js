var base_url = "http://cc.localhost/kc-fullstack-dev-tech-task/";
var base_api_url = "http://cc.localhost/kc-fullstack-dev-tech-task/api/";

document.addEventListener("DOMContentLoaded", function () {
    loadCategories();
    loadCourses();
});

function loadCategories() {
    fetch(base_api_url + "categories")
        .then(response => response.json())
        .then(data => {
            const categoryList = document.getElementById("category-list");
            categoryList.innerHTML = "";

            // Function to calculate total courses including child categories
            function calculateTotalCourses(category) {
                let totalCourses = Number(category.course_count) || 0; // Convert to number
                
                if (category.children && category.children.length) {
                    category.children.forEach(child => {
                        totalCourses += calculateTotalCourses(child);
                    });
                }
                
                category.total_course_count = totalCourses; // Store the computed total
                return totalCourses;
            }

            // First, update all categories with total course counts
            data.forEach(category => calculateTotalCourses(category));

            // Render the categories with the updated course counts
            function renderCategory(category, parentElement) {
                let li = document.createElement("li");
                li.innerHTML = `<p>${category.name} (${category.total_course_count})</p>`;
                li.dataset.categoryId = category.id;
                li.classList.add(category.parent_id ? "child-category" : "parent-category");

                li.addEventListener("click", (event) => {
                    event.stopPropagation();
                    loadCourses(category.id);
                });

                parentElement.appendChild(li);

                if (category.children && category.children.length) {
                    let ul = document.createElement("ul");
                    ul.classList.add("nested-category");
                    li.appendChild(ul);

                    category.children.forEach(child => renderCategory(child, ul));
                }
            }

            data.forEach(category => renderCategory(category, categoryList));
        })
        .catch(error => console.error("Error fetching categories:", error));
}

function loadCourses(categoryId = null) {
    let url = base_api_url+"courses";
    if (categoryId) {
        url += `?category_id=${categoryId}`;
    }

    fetch(url)
        .then(response => response.json())
        .then(data => {
            const courseList = document.getElementById("course-list");
            courseList.innerHTML = "";

            data.forEach(course => {
                let div = document.createElement("div");
                div.classList.add("course-card");
                div.innerHTML = `
                    <img src="${course.preview}" alt="Course Image">
                    <h3 class="limit-text">${course.name}</h3>
                    <p class="limit-text-2">${course.description}</p>
                    <span class="course-category">${course.main_category_name}</span>
                `;
                courseList.appendChild(div);
            });
        });
}