function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
} 

function calculate_this() {
    _YEAR = "";
    _MONTH = "";
    _YEAR = parseInt($("input:radio.rdo_year:checked").val());
    
    //var checkedVals = $('.rdo_month:checkbox:checked').map(function () { return this.id; }).get();   
    //_MONTH = checkedVals.join(",");
    //_MONTH = _MONTH.replaceAll("rdo_month_", "");

    var checkedProb = $('.rdo_prob:checkbox:checked').map(function () { return this.id; }).get();
    _PROB = checkedProb.join(",");
    _PROB = _PROB.replaceAll("rdo_prob_", "");

/*DATA LOOP HERE*/

    $("#tb_list").find("tr:gt(0)").remove();
    var final_amt = ["รวม", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

    for (s = 0; s < STAFF_DATA.length; s++) {
        //Clean
        STAFF_DATA[s][2] = 0; //1
        STAFF_DATA[s][3] = 0; //2
        STAFF_DATA[s][4] = 0; //3
        STAFF_DATA[s][5] = 0; //4
        STAFF_DATA[s][6] = 0; //5
        STAFF_DATA[s][7] = 0; //6
        STAFF_DATA[s][8] = 0; //7
        STAFF_DATA[s][9] = 0; //8
        STAFF_DATA[s][10] = 0; //9
        STAFF_DATA[s][11] = 0; //10
        STAFF_DATA[s][12] = 0;//11
        STAFF_DATA[s][13] = 0;//12
        STAFF_DATA[s][14] = 0;// MONTH = 0 (สร้างใหม่ 2021-04-16)

        //Compute
        /*
        '0   SALE_ORDER_YEAR
        '1   SALE_ORDER_MONTH
        '2   SALE_HOSPITAL
        '3   BRAND_NAME
        '4   REVENUE
        '5   ORDERPROB_ID
        '6   ORDERPROB_NAME
        */
        for (i = 0; i < JOB_DATA.length; i++) {
            if (_YEAR === JOB_DATA[i][0] && _PROB.indexOf(JOB_DATA[i][5]) !== -1 && JOB_DATA[i][2] === STAFF_DATA[s][0] && JOB_DATA[i][3] === STAFF_DATA[s][1]) {
                STAFF_DATA[s][JOB_DATA[i][1] + 2] += JOB_DATA[i][4];
            }
        }

        //Display
        var TMP_ROW = "";
        var amt_row = 0;
        TMP_ROW = "<tr>";

        TMP_ROW = TMP_ROW + "<td>" + STAFF_DATA[s][0] + "</td><td>" + STAFF_DATA[s][1] + "</td>";

        for (j = 1; j <= 14; j++) {
            if (j == 14) {
                //Summary Column 
                TMP_ROW = TMP_ROW + "<td style='text-align:right'><b>" + numberWithCommas(amt_row) + "</b></td>";
                final_amt[j] = final_amt[j] + amt_row;
            } else {
                TMP_ROW = TMP_ROW + "<td style='text-align:right'>" + numberWithCommas(STAFF_DATA[s][j + 1]) + "</td>";
                amt_row = amt_row + STAFF_DATA[s][j + 1];
                final_amt[j] = final_amt[j] + STAFF_DATA[s][j + 1];
            }
        }

        TMP_ROW = TMP_ROW + "</tr>";
        $("#tb_list tbody").append(TMP_ROW);
    }

    var tmp_final_row = "<tr>";
    for (j = 0; j <= 14; j++) {
        if (j == 0) {
            tmp_final_row = tmp_final_row + "<th colspan = '2' style='text-align:right'>" + final_amt[j] + "</th>";
        } else {
            tmp_final_row = tmp_final_row + "<th style='text-align:right' id='xxx_" + j + "' >" + numberWithCommas(final_amt[j]) + "</th>";
        }
    }
    tmp_final_row = tmp_final_row + "</tr>";
    $("#tb_list tbody").append(tmp_final_row);



}



function myFunction() {
    var row_amt = ["รวม", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];// 0 - 12 & Sum
    // Declare variables
    var input1, input2, filter1, filter2, table, tr, td1, td2, i, txtValue;
    filter1 = $("#myInput1").val().toUpperCase();
    filter2 = $("#myInput2").val().toUpperCase();
    table = document.getElementById("tb_list");
    tr = table.getElementsByTagName("tr");

    // Loop through all table rows, and hide those who don't match the search query
    for (i = 1; i < tr.length; i++) {
        td1 = tr[i].getElementsByTagName("td")[0];
        td2 = tr[i].getElementsByTagName("td")[1];
        if (td1) {
            txtValue1 = td1.textContent || td1.innerText;
            txtValue2 = td2.textContent || td2.innerText;

            if ((txtValue1.toUpperCase().indexOf(filter1) > -1) && (txtValue2.toUpperCase().indexOf(filter2) > -1)) {
                tr[i].style.display = "";

                for (j = 2; j <= 15; j++) {
                    row_amt[j] += parseInt(tr[i].getElementsByTagName("td")[j].textContent.replaceAll(",", "").replaceAll("<b>", "").replaceAll("</b>", ""));//ค้างเช็คบรรทัดนี้ 2021-11-12
                }

            } else {
                tr[i].style.display = "none";
            }
        }
    }

    var sum_amt = 0;
    for (j = 1; j <= 13; j++) {
        $("#xxx_" + j).text(numberWithCommas(row_amt[j + 1]));
        sum_amt += row_amt[j + 1];
    }
    $("#xxx_14").text(numberWithCommas(sum_amt));

}