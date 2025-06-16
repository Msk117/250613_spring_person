console.log("boardModify.js in");



const csrfHeader = document.querySelector('meta[name="_csrf_header"]').getAttribute('content');
const csrfToken = document.querySelector('meta[name="_csrf"]').getAttribute('content');

document.addEventListener('click', (e)=>{
    if (e.target.classList.contains("file-x")) {
        let uuid = e.target.dataset.uuid;
        removeFileToServer(uuid).then(result => {
            if (result == '1') {
                e.target.closest('li').remove();
            }
        })
    }
});


async function removeFileToServer(uuid) {
    try {
        const url = "/board/file/"+uuid;
        const config={
            method:'delete',
            headers : {
                [csrfHeader] : csrfToken
            }
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}

document.getElementById('logoutLink').addEventListener('click', (e)=>{
    e.preventDefault(); 
    document.getElementById('logoutForm').submit();
})