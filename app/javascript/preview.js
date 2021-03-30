window.addEventListener('load', () => {
  const uploader1 = document.querySelector('.shop-image-uploader1');
  uploader1.addEventListener('change', (e) => {
    const file1 = uploader1.files[0];
    const reader1 = new FileReader();
    reader1.readAsDataURL(file1);
    reader1.onload = () => {
      const image = reader1.result;
      document.querySelector('.upload-image-paste1').setAttribute('src', image);
    }
  });
  const uploader2 = document.querySelector('.shop-image-uploader2');
  uploader2.addEventListener('change', (e) => {
    const file2 = uploader2.files[0];
    const reader2 = new FileReader();
    reader2.readAsDataURL(file2);
    reader2.onload = () => {
      const image = reader2.result;
      document.querySelector('.upload-image-paste2').setAttribute('src', image);
    }
  });
  const uploader3 = document.querySelector('.shop-image-uploader3');
  uploader3.addEventListener('change', (e) => {
    const file3 = uploader3.files[0];
    const reader3 = new FileReader();
    reader3.readAsDataURL(file3);
    reader3.onload = () => {
      const image = reader3.result;
      document.querySelector('.upload-image-paste3').setAttribute('src', image);
    }
  });
  const uploader4 = document.querySelector('.shop-image-uploader4');
  uploader4.addEventListener('change', (e) => {
    const file4 = uploader4.files[0];
    const reader4 = new FileReader();
    reader4.readAsDataURL(file4);
    reader4.onload = () => {
      const image = reader4.result;
      document.querySelector('.upload-image-paste4').setAttribute('src', image);
    }
  });
  const uploader5 = document.querySelector('.shop-image-uploader5');
  uploader5.addEventListener('change', (e) => {
    const file5 = uploader5.files[0];
    const reader5 = new FileReader();
    reader5.readAsDataURL(file5);
    reader5.onload = () => {
      const image = reader5.result;
      document.querySelector('.upload-image-paste5').setAttribute('src', image);
    }
  });
});