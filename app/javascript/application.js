//= require rails-ujs
//= require toastr
document.addEventListener("DOMContentLoaded", function () {
    toastr.options = {
        "closeButton": true,
        "debug": false,
        "newestOnTop": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "preventDuplicates": true,
        "onclick": null,
        "showDuration": "300",
        "hideDuration": "1000",
        "timeOut": "3000",
        "extendedTimeOut": "1000",
        "showEasing": "swing",
        "hideEasing": "linear",
        "showMethod": "fadeIn",
        "hideMethod": "fadeOut"
      };
    $('.file-table').DataTable({});
});

document.addEventListener("DOMContentLoaded", () => {
    const modal = document.getElementById("shareModal");
    const modalCloseBtn = document.getElementById("closeModal");
    const publicUrlInput = document.getElementById("public-url");
    const copyUrlBtn = document.getElementById("copy-url-btn");
  
    // Listen for share button clicks
    document.querySelectorAll(".btn-share").forEach((btn) => {
      btn.addEventListener("ajax:success", (event) => {
        const url = event.detail[0].public_url; // Get public URL from response
        publicUrlInput.value = url;
        modal.style.display = "block";
      });
    });
  
    // Close modal
    modalCloseBtn.onclick = () => {
      modal.style.display = "none";
    };
  
    window.onclick = (event) => {
      if (event.target === modal) {
        modal.style.display = "none";
      }
    };
  
    // Copy URL to clipboard
    copyUrlBtn.onclick = () => {
      publicUrlInput.select();
      document.execCommand("copy");
      alert("Copied to clipboard!");
    };
  });
  