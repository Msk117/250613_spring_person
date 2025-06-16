console.log("boardRegisterFile.js in");

document.getElementById('trigger').addEventListener('click', ()=>{
    document.getElementById('file').click();
});


const regExp = new RegExp("\.(exe|jar|msi|dll|sh|bat)$", "i");
const maxSize = 1024 * 1024 * 20;

function fileValidation(fileName, fileSize) {
    if (regExp.test(fileName)) {
        return 0;
    } else if (fileSize > maxSize) {
        return 0;
    } else {
        return 1;
    }
}

document.addEventListener('change', (e)=>{
    if (e.target.id == 'file') { 
        const fileObj = document.getElementById('file').files;
        console.log(fileObj);

       
        const div = document.getElementById('fileZone');
        div.innerHTML = ""; 

        document.getElementById('regBtn').disabled = false;

        let isOk = 1; 
        let ul = `<ul class="list-group list-group-flush">`;

       
        for(let file of fileObj){
            let vaildResult = fileValidation(file.name, file.size); 
            isOk *= vaildResult;
            ul += `<li class="list-group-item">`;
            ul += `<div class="mb-3">`;
            ul += `${vaildResult ? '<div class="fw-bold text-success">업로드 가능</div>' : '<div class="fw-bold text-danger">업로드 불가능</div>'}`;
            ul += `${file.name}</div>`;
            ul += `<span class="badge text-bg-${vaildResult ? 'success' : 'danger'}">${file.size.toLocaleString()} Bytes</span>`;
            ul += `</li>`;
        }

        ul += `</ul>`;
        div.innerHTML = ul;

        if (isOk === 0) {
            
            document.getElementById('regBtn').disabled = true;
        }

        
    }
});
