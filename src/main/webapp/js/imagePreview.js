// Global Image Preview with Cancel Button Logic
function setupLivePreview(inputId, previewId) {
    var input = document.getElementById(inputId);
    var previewContainer = document.getElementById(previewId);
    
    if (input && previewContainer) {
        previewContainer.style.position = 'relative';
        previewContainer.style.display = 'inline-block';

        input.addEventListener('change', function(event) {
            var file = event.target.files[0];
            previewContainer.innerHTML = '';
            
            // Check if file is an image
            if (file && file.type.startsWith('image/')) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    var img = document.createElement('img');
                    img.src = e.target.result;
                    img.className = 'img-fluid img-thumbnail';
                    img.style.maxWidth = '150px';
                    img.style.display = 'block';
                    img.style.marginTop = '10px';
                    
                    var btn = document.createElement('button');
                    btn.innerHTML = '&times;';
                    btn.type = 'button';
                    btn.title = 'Remove Image';
                    btn.style.position = 'absolute';
                    btn.style.top = '0px';
                    btn.style.right = '-10px';
                    btn.style.background = '#dc2626';
                    btn.style.color = 'white';
                    btn.style.border = 'none';
                    btn.style.borderRadius = '50%';
                    btn.style.width = '24px';
                    btn.style.height = '24px';
                    btn.style.lineHeight = '1';
                    btn.style.cursor = 'pointer';
                    btn.style.boxShadow = '0 2px 4px rgba(0,0,0,0.2)';
                    btn.style.display = 'flex';
                    btn.style.alignItems = 'center';
                    btn.style.justifyContent = 'center';
                    btn.style.fontSize = '18px';
                    btn.style.fontWeight = 'bold';
                    
                    btn.onclick = function() {
                        input.value = '';
                        previewContainer.innerHTML = '';
                    };
                    
                    previewContainer.appendChild(img);
                    previewContainer.appendChild(btn);
                }
                reader.readAsDataURL(file);
            }
        });
    }
}
