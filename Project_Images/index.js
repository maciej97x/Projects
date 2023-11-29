const accessKey = "-jaU3x9bu3065DZhmEEDfGXZUsWdnIXFt2YngpFL1Dk"

const formEl = document.querySelector("form")
const searchInputEl = document.getElementById("search-input")
const searchResultsEl = document.querySelector(".search-results")
const showMoreButton = document.getElementById("show-more-button")

let inputData = "";
let page = 1;

async function searchImages(){
    inputData = searchInputEl.value;
    const url = `https://api.unsplash.com/search/photos?page=${page}&query=${inputData}&client_id=${accessKey}`;
    console.log(url);
    const response = await fetch(url);
    const data = await response.json();
    if (page === 1) {
         searchResultsEl.innerHTML = "";
     }

    const results = data.results;

    console.log(results);
}

formEl.addEventListener("submit", (event)=>{
    event.preventDefault();
    page = 1;
    searchImages();
});