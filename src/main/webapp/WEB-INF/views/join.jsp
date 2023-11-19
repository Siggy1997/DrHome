
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Morpheus Image Upload Sample</title>
</head>

<body>
  <h1>Upload Sample</h1>
  <div>
    <button id="picker">M.media.picker</button>
  </div>
  <div id="box"></div>
  <div>
    <button id="upload">Upload Current Image</button>
  </div>
  <div id="progress"></div>
  <div id="upload-box"></div>
</body>
<script src="./js/jquery-3.7.0.min.js"></script>
<script src="/js/wnInterface.js"></script>
<script src="/js/mcore.min.js"></script>
<script src="/js/mcore.extends.js"></script>
<script>

  (function () {

    $.imagePicker = function () {
      return new Promise((resolve) => {
        M.media.picker({
          mode: "SINGLE",
          media: "PHOTO",
          // path: "/media", // 값을 넘기지않아야 기본 앨범 경로를 바라본다.
          column: 3,
          callback: (status, result) => {
            resolve({ status, result })
          }
        });
      })
    }

    $.convertBase64ByPath = function (imagePath) {
      if (typeof imagePath !== 'string') throw new Error('imagePath must be string')
      return new Promise((resolve) => {
        M.file.read({
          path: imagePath,
          encoding: 'BASE64',
          indicator: true,
          callback: function (status, result) {
            resolve({ status, result })
          }
        });
      })
    }

    $.uploadImageByPath = function (targetImgPath, progress) {
      return new Promise((resolve) => {
        const _options = {
          url: `${location.origin}/file/upload`,
          header: {},
          params: {},
          body: [
            // multipart/form-data 바디 데이터
            { name: "file", content: targetImgPath, type: "FILE" },
          ],
          encoding: "UTF-8",
          finish: (status, header, body, setting) => {
            resolve({ status, header, body })
          },
          progress: function (total, current) {
            progress(total, current);
          }
        }
        M.net.http.upload(_options);
      })
    }

  })();


  $(function () {

    let selectImagePath = '';
    let $previewImg = null;
    let $uploadImg = null;
    const $box = $('#box');
    const $uploadBox = $('#upload-box');
    const $progress = $('#progress');
    const $picker = $('#picker');
    const $upload = $('#upload');



    $picker.on('click', () => {
      if ($previewImg !== null) {
        $previewImg.remove();
        $previewImg = null;
      }
      selectImagePath = '';
      $.imagePicker()
        .then(({ status, result }) => {
          if (status === 'SUCCESS') {
            selectImagePath = result.path;
            return $.convertBase64ByPath(selectImagePath)
          } else {
            return Promise.reject('이미지 가져오기 실패')
          }
        })
        .then(({ status, result }) => {
          if (status === 'SUCCESS') {
            $previewImg = $(document.createElement('img'))
            $previewImg.attr('height', '200px')
            $previewImg.attr('src', "data:image/png;base64," + result.data)
            $box.append($previewImg);
          } else {
            return Promise.reject('BASE64 변환 실패')
          }
        })
        .catch((err) => {
          if (typeof err === 'string') alert(err)
          console.error(err)
        })
    })

    $upload.on('click', () => {
      if (selectImagePath === '') return alert('이미지를 선택해주세요.')
      if ($uploadImg) {
        $uploadImg.remove();
        $uploadImg = null;
      }
      $progress.text('')
      $.uploadImageByPath(selectImagePath, (total, current) => {
        console.log(`total: ${total} , current: ${current}`)
        $progress.text(`${current}/${total}`)
      })
        .then(({
          status, header, body
        }) => {
          // status code
          if (status === '200') {
            $progress.text('업로드 완료')
            const bodyJson = JSON.parse(body)
            $uploadImg = $(document.createElement('img'))
            $uploadImg.attr('height', '200px')
            $uploadImg.attr('src', bodyJson.fullpath)
            $uploadBox.append($uploadImg)
          } else {
            return Promise.reject('업로드를 실패하였습니다.')
          }
        })
        .catch((err) => {
          if (typeof err === 'string') alert(err)
          console.error(err)
        })
    })
  });


</script>

</html>
