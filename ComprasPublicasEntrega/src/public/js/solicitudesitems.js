function tab1_To_tab2()
{
    var table1 = document.getElementById("table1"),
        table2 = document.getElementById("table2"),
        checkboxes = document.getElementsByName("check-tab1");
    console.log("Val1 = " + checkboxes.length);
    for(var i = 0; i < checkboxes.length; i++)
        if(checkboxes[i].checked)
        {
            // create new row and cells
            var newRow = table2.insertRow(table2.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3);
            // add values to the cells
            cell1.innerHTML = table1.rows[i+1].cells[0].innerHTML;
            cell2.innerHTML = table1.rows[i+1].cells[1].innerHTML;
            cell3.innerHTML = "<input type='checkbox' name='check-tab2'>";
            cell4.innerHTML = "<input type=\"number\" name=\"quantity\" min=\"1\" max=\"100000\">";

            // remove the transfered rows from the first table [table1]
            var index = table1.rows[i+1].rowIndex;
            table1.deleteRow(index);
            // we have deleted some rows so the checkboxes.length have changed
            // so we have to decrement the value of i
            i--;
            console.log(checkboxes.length);
        }
}


function tab2_To_tab1()
{
    var table1 = document.getElementById("table1"),
        table2 = document.getElementById("table2"),
        checkboxes = document.getElementsByName("check-tab2");
    console.log("Val1 = " + checkboxes.length);
    for(var i = 0; i < checkboxes.length; i++)
        if(checkboxes[i].checked)
        {
            // create new row and cells
            var newRow = table1.insertRow(table1.length),
                cell1 = newRow.insertCell(0),
                cell2 = newRow.insertCell(1),
                cell3 = newRow.insertCell(2),
                cell4 = newRow.insertCell(3);
            // add values to the cells
            cell1.innerHTML = table2.rows[i+1].cells[0].innerHTML;
            cell2.innerHTML = table2.rows[i+1].cells[1].innerHTML;
            cell3.innerHTML = "<input type='checkbox' name='check-tab1'>";
            cell4.innerHTML = "";

            // remove the transfered rows from the second table [table2]
            var index = table2.rows[i+1].rowIndex;
            table2.deleteRow(index);
            // we have deleted some rows so the checkboxes.length have changed
            // so we have to decrement the value of i
            i--;
            console.log(checkboxes.length);
        }
}
            