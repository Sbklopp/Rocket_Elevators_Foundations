// jQuery(function() {
//     initPage();
// });

// jQuery(window).bind('page:change', function() {
//     initPage();
// });

jQuery(function() {
    jQuery('#building-all').hide();
    jQuery('#battery-all').hide();
    jQuery('#column-all').hide();
    jQuery('#elevator-all').hide();
    
    
    jQuery("select#customer").change(function() {
        jQuery('#building-all').show();
        var customer_id = jQuery(this).val();
        if (customer_id == "") {
            jQuery('#building-all').hide();
            jQuery("#battery-all").hide();
            jQuery("#column-all").hide();
            jQuery("#elevator-all").hide();
            jQuery("select#building option").remove();
            jQuery("select#battery option").remove();
            jQuery("select#column option").remove();
            jQuery("select#elevator option").remove();
        } else {
            jQuery.ajax({
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
                    jQuery("select#building option").remove();
                    jQuery("select#battery option").remove();
                    jQuery("select#column option").remove();
                    jQuery("select#elevator option").remove();
                    var row = "<option value=\"" + "" + "\">" + "None" + "</option>";
                    jQuery(row).appendTo("select#building");
                    jQuery(row).appendTo("select#battery");
                    jQuery(row).appendTo("select#column");
                    jQuery(row).appendTo("select#elevator");
                    jQuery.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" + j.id + "</option>";
                        jQuery(row).appendTo("select#building");
                    });
                }
            });
        }
    });

    jQuery("select#building").change(function() {
        jQuery("#battery-all").show(); 
        var building_id = jQuery(this).val();
        if (building_id == "") {
            jQuery("#battery-all").hide();
            jQuery("column-all").hide();
            jQuery("#elevator-all").hide();
            jQuery("select#battery option").remove(); 
            jQuery("select#column option").remove();
            jQuery("select#elevator option").remove();
        } else {
            jQuery.ajax({
                dataType: "json",
                cache: false,
                url: '/get_batteries_by_building/' + building_id,
                timeout: 5000,
                error: function(XMLHttpRequest, errorTextStatus, error) {
                    alert("Failed to reach submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data) { 
                    jQuery("select#battery option").remove();
                    jQuery("select#column option").remove();
                    jQuery("select#elevator option").remove();
                    
                    var row = "<option value=\"" + "" + "\">" + "None" + "</option>";;
                    jQuery(row).appendTo("select#battery");
                    jQuery(row).appendTo("select#column");
                    jQuery(row).appendTo("select#elevator");

                    jQuery.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" +  + j.id + " Status: " + j.status + "</option>";
                      
                    jQuery(row).appendTo("select#battery");
                        
                    });
                }
            });
        }
    }); 

    jQuery("select#battery").change(function() {
        jQuery("#column-all").show();
        var battery_id = jQuery(this).val();
        if (battery_id == "") {
            jQuery("#column-all").hide();
            jQuery("#elevator-all").hide();
            jQuery("select#column option").remove();
            jQuery("select#elevator option").remove();
        } else {
            jQuery.ajax({
                dataType: "json",
                cache: false,
                url: '/get_columns_by_batteries/' + battery_id,
                timeout: 5000,
                error: function(XMLHttpRequest, errorTextStatus, error) {
                    alert("Failed to reach submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data) { 
                    jQuery("select#column option").remove();
                    jQuery("select#elevator option").remove();
                    var row = "<option value=\"" + "" + "\">" + "None" + "</option>";
                    jQuery(row).appendTo("select#column");
                    jQuery(row).appendTo("select#elevator");

                    jQuery.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" +  + j.id + " Status: " + j.status + "</option>";
                        jQuery(row).appendTo("select#column");
                        jQuery(row).appendTo("select#elevator");
                    });
                }
            });
        }
    }); 
    jQuery("select#column").change(function() {
        jQuery("#elevator-all").show();
        var column_id = jQuery(this).val();
        if (column_id == "") {
            jQuery("#elevator-all").hide();
            jQuery("select#elevator option").remove();
        } else {
            jQuery.ajax({
                dataType: "json",
                cache: false,
                url: '/get_elevators_by_columns/' + column_id,
                timeout: 5000,
                error: function(XMLHttpRequest, errorTextStatus, error) {
                    alert("Failed to reach submit : " + errorTextStatus + " ;" + error);
                },
                success: function(data) { 
                    jQuery("select#elevator option").remove();
                    var def_row = "<option value=\"" + "" + "\">" + "None" + "</option>";
                    jQuery(def_row).appendTo("select#elevator");
                    jQuery.each(data, function(i, j) { 
                        var row = "<option value=\"" + j.id + "\">" +  + j.id + " Status: " + j.status + "</option>";
                        jQuery(row).appendTo("select#elevator");
                    });
                }
            });
        }
    }); 
});

