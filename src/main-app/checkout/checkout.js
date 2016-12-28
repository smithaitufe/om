export class Checkout {
  entity = {};
  attached(){
    $(".show-modal").click(function(e){
      e.preventDefault();
       
        $("#address-modal").modal({
            backdrop: 'static',
            keyboard: false
        });
    });
  }
}
