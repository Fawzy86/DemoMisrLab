function PrintData(data) {
    try {
        if (data != null && data.length > 0) {
            var w = window.open();
            if (w) {
                w.document.write(data);
                w.print();
                w.close();
            } else {
                alert("The browser is preventing the window, please allow the popup")
            }

        }
    } catch (err) {
        console.log(err.message + " : " + err.description);
    }
}

function Print() {
    console.log($(TEmppp)[0])//.print();
    console.log($(TEmppp));
    console.log($(TEmppp)[0].innerHTML);
    /*  var printContents = $(TEmppp)[0].innerHTML;
      var originalContents = document.body.innerHTML;

      document.body.innerHTML = printContents;
     
      window.print();

      document.body.innerHTML = originalContents;
      */
    /*
    w = window.open();
    w.document.write($(TEmppp).html());
    w.print();
    w.close();*/
    //  window.print();
    // $(TEmppp)[0].printElement();
    //var data = $(TEmppp)[0].innerHTML;
    //var mywindow = window.open('', 'TEmppp', 'height=400,width=600');
    //mywindow.document.write('<html><head><title>my div</title>');
    ///*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
    //mywindow.document.write('</head><body >');
    //mywindow.document.write(data);
    //mywindow.document.write('</body></html>');

    //mywindow.document.close(); // necessary for IE >= 10
    //mywindow.focus(); // necessary for IE >= 10

    //mywindow.print();
    //mywindow.close();

    //var restorepage = $('body').html();
    //var printcontent = $('#TEmppp').clone();
    //$('body').empty().html(printcontent);
    //window.print();
    //$('body').html(restorepage);

    /*

    var id = "TEmppp";

    var contents = $("#" + id).html();

    if ($("#printDiv").length == 0) {
        var printDiv = null;
        printDiv = document.createElement('div');
        printDiv.setAttribute('id', 'printDiv');
        printDiv.setAttribute('class', 'printable');
        $(printDiv).appendTo('body');
    }

    $("#printDiv").html(contents);

    window.print();

    $("#printDiv").remove();

    */

}