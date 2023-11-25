const inputEl = document.getElementById("input")

async function fetchAPI(word){
    try {
        const url = `https://api.dictionaryapi.dev/api/v2/entries/en/${word}`;
        const result = await fetch(url).then((res) => res.json());
    } catch (error) {
        console.log(error);
    }
}


inputEl.addEventListener("keyup", (e)=>{
    if(e.target.value && e.key == "Enter"){
        fetchAPI(e.target.value)
    }
})