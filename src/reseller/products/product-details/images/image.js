import {
  HttpClient
} from 'aurelia-fetch-client';

export class Image {
  selectedFiles;
  constructor() {

  }
  upload() {
    let file = this.selectedFiles[0];
    let data = new window.FormData();
    data.append('image', file);
    this.http = new HttpClient().configure(x => {
      x.withDefaults({
        mode: 'cors',
        headers: {
          "Access-Control-Allow-Origin": "*"
        }
      })
    });
    this.http.fetch("http://localhost:4000/api/v1/images", {
      method: 'POST',
      body: data
    }).then(response => response.json()).then(response => {
      console.log(response);
    });
  }
}
export class FileListToArrayValueConverter {
  toView(fileList) {
    let files = [];
    if (!fileList) {
      return files;
    }
    for (let i = 0; i < fileList.length; i++) {
      files.push(fileList.item(i));
    }
    return files;
  }
}

export class BlobToUrlValueConverter {
  toView(blob) {
    return URL.createObjectURL(blob);
  }
}

$(document).on('change', ':file', function () {
  var input = $(this),
    numFiles = input.get(0).files ? input.get(0).files.length : 1,
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
  input.trigger('fileselect', [numFiles, label]);
});
$(document).ready(function () {
  var previousValues = "";
  $(':file').on('fileselect', function (event, numFiles, label) {
    var input = $(this).parents('.input-group').find(':text');
    if (input.length) {
      // previousValues = input.val();
      // if(previousValues.length) previousValues += "; " + label;
      input.val(label);
    }
  });
  $(".readonly").on('keydown paste', function (e) {
    e.preventDefault();
  });
});
