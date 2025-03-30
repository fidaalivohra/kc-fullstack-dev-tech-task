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
            const categoryTitle = document.getElementById("category-title"); // Title Element
            let selectedCategory = null; // Track selected category

            categoryList.innerHTML = "";

            function calculateTotalCourses(category) {
                let totalCourses = Number(category.course_count) || 0;
                if (category.children && category.children.length) {
                    category.children.forEach(child => {
                        totalCourses += calculateTotalCourses(child);
                    });
                }
                category.total_course_count = totalCourses;
                return totalCourses;
            }

            data.forEach(category => calculateTotalCourses(category));

            function renderCategory(category, parentElement) {
                let li = document.createElement("li");
                let p = document.createElement("p");
            
                p.textContent = `${category.name} (${category.total_course_count})`;
                li.dataset.categoryId = category.id;
                li.classList.add(category.parent_id ? "child-category" : "parent-category");
            
                p.addEventListener("click", (event) => {
                    event.stopPropagation();

                    document.querySelectorAll(".selected-category").forEach(el => el.classList.remove("selected-category"));

                    p.classList.add("selected-category");
                    
                    categoryTitle.textContent = `${category.name}`;

                    loadCourses(category.id);
                });
            
                li.appendChild(p);
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