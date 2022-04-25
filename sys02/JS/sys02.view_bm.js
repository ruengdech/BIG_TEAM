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
        for (i = 0; i < JOB_DATA.length; i++) {
            if (_YEAR === JOB_DATA[i][0] && _PROB.indexOf(JOB_DATA[i][3]) !== -1 && JOB_DATA[i][2] === STAFF_DATA[s][1]) {
                STAFF_DATA[s][JOB_DATA[i][1] + 2] += JOB_DATA[i][5];
            }
        }

        //Display
        var TMP_ROW = "";
        var amt_row = 0;
        TMP_ROW = "<tr>";

        TMP_ROW = TMP_ROW + "<td>" + STAFF_DATA[s][1] + "</td>";

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

        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][2]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][3]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][4]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][5]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][6]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][7]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][8]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][9]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][10]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][11]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][12]) + "</td>";
        //TMP_ROW = TMP_ROW + "<td>" + numberWithCommas(STAFF_DATA[s][13]) + "</td>";

        TMP_ROW = TMP_ROW + "</tr>";
        $("#tb_list tbody").append(TMP_ROW);
    }

    var tmp_final_row = "<tr>";
    for (j = 0; j <= 14; j++) {
        if (j == 0) {
            tmp_final_row = tmp_final_row + "<th style='text-align:right'>" + final_amt[j] + "</th>";
        } else {
            tmp_final_row = tmp_final_row + "<th style='text-align:right'>" + numberWithCommas(final_amt[j]) + "</th>";
        }
    }
    tmp_final_row = tmp_final_row + "</tr>";
    $("#tb_list tbody").append(tmp_final_row);


    //'0   SALE_ORDER_YEAR
    //'1   SALE_ORDER_MONTH
    //'2   STAFF_NAME
    //'3   ORDERPROB_ID
    //'4   ORDERPROB_NAME
    //'5   REVENUE
    //'6   STAFF_ID


}