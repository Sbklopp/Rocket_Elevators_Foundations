$(function() {
    initPage();
});

$(window).bind('page:change', function() {
    initPage();
});

function initPage() {
    $('#building-all').hide();
    $('#battery-all').hide();
    $('#column-all').hide();
    $('#elevator-all').hide();
    
    
    $("select#customer").change(function() {
        $('#building-all').show();
        var customer_id = $(this).val();
        if (customer_id == "") {
            $('#building-all').hide();
            $("#battery-all").hide();
            $("#column-all").hide();
            $("#elevator-all").hide();
            $("select#building option").remove();
        } else {
            $.ajax({
                dataType: "json",
                cache: false,
                url: '/get_buildings_by_customer/' + customer_id,
                timeout: 5000,
                method: "GET",
                error: function(XMLHttpRequest, errorTextStatus, error) {
                    console.log(XMLHttpRequest.responseText)
                    alert("Failed to submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data) { 
                    $("select#building option").remove();
                    var row = "<option value=\"" + "" + "\">" + "Customer" + "</option>";
                    $(row).appendTo("select#building");
                    $.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" + j.id + "</option>";
                        $(row).appendTo("select#building");
                    });
                }
            });
        }
    });

    $("select#building").change(function() {
        $("#battery-all").show(); 
        var building_id = $(this).val();
        if (building_id == "") {
            $("#battery-all").hide();
            $("column-all").hide();
            $("#elevator-all").hide();
            $("select#battery option").remove();
        } else {
            $.ajax({
                dataType: "json",
                cache: false,
                url: '/get_batteries_by_building/' + building_id,
                timeout: 5000,
                error: function(XMLHttpRequest, errorTextStatus, error) {
                    alert("Failed to reach submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data) { 
                    $("select#battery option").remove();
                    var row = "<option value=\"" + "" + "\">" + "None" + "</option>";;
                    $(row).appendTo("select#battery");
                    $.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" +  + j.id + " Status: " + j.status + "</option>";
                      
                        $(row).appendTo("select#battery");
                    });
                }
            });
        }
    }); 

    $("select#battery").change(function() {
        $("#column-all").show();
        var battery_id = $(this).val();
        if (battery_id == "") {
            $("#column-all").hide();
            $("#elevator-all").hide();
            $("select#column option").remove();
        } else {
            $.ajax({
                dataType: "json",
                cache: false,
                url: '/get_columns_by_batteries/' + battery_id,
                timeout: 5000,
                error: function(XMLHttpRequest, errorTextStatus, error) {
                    alert("Failed to reach submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data) { 
                    $("select#column option").remove();
                    var def_row = "<option value=\"" + "" + "\">" + "None" + "</option>";
                    $(def_row).appendTo("select#column");
                    $.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" +  + j.id + " Status: " + j.status + "</option>";
                        $(row).appendTo("select#column");
                    });
                }
            });
        }
    }); 
    $("select#column").change(function() {
        $("#elevator-all").show();
        var column_id = $(this).val();
        if (column_id == "") {
            $("#elevator-all").hide();
            $("select#elevator option").remove();
        } else {
            $.ajax({
                dataType: "json",
                cache: false,
                url: '/get_elevators_by_columns/' + column_id,
                timeout: 5000,
                error: function(XMLHttpRequest, errorTextStatus, error) {
                    alert("Failed to reach submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data) { 
                    $("select#elevator option").remove();
                    var def_row = "<option value=\"" + "" + "\">" + "None" + "</option>";
                    $(def_row).appendTo("select#elevator");
                    $.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" +  + j.id + " Status: " + j.status + "</option>";
                        $(row).appendTo("select#elevator");
                    });
                }
            });
        }
    }); 
}

// $(function() {
    
// }); 