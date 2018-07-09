// Auteurs: Mohammad Hossein ERFANIAN AZMOUDEH (20031314) et Hanifa MALLEK (P1005515)

//Les variable globales
var deplace = 0;
var cellul = [];
var row = [];
var cellLen = 0;
var rowLen = 0;
var colLen = 0;
//cette fonction prend les dimension de l'image et l'ajuste selon les nombre de lignes et de colomns
function dimImage(image, rows, cols) {
    deplace = 0;
    $("#count").text(deplace + "");
    if (rows == 0) { rows = 2; }
    if (cols == 0) { cols = 2; }
    if (image == "") {
        image = "http://orig02.deviantart.net/160f/f/2010/118/8/5/pretty_nature_by_tylercuddlebutt.jpg";
    }
    var imgObj = new Image();
    var imgH = imgW = 0;
    imgObj.src = image;
    imgObj.onload = function() {
        var ratio = 0;
        if (cols > rows) {
            if (this.width > this.height) {
                imgW = 850 + parseInt(cols) - 1;
                imgH = 550 + parseInt(rows) - 1;
            } else {
                imgH = 550 + parseInt(rows) - 1;
                imgW = 550 + parseInt(cols) - 1;
            }
        } else {
            imgW = 550 + parseInt(cols) - 1;
            imgH = 550 + parseInt(rows) - 1;
        }
        createGrid(rows, cols, imgW, imgH);
        showImage(image, imgW, imgH);
    };
}
//cette fonction cree le grille par l'element table considerant le nbr de ligne et le nbr de colomn et la taille de l'image
function createGrid(rows, cols, w, h) {
    var t = document.getElementsByTagName("table");
    if (t.length > 0) {
        $("table").remove();
    }
    var grid = document.createElement('table');
    var tr, td = "";
    $(grid).attr("id", "grid");
    for (var i = 0; i < rows; i++) {
        tr = document.createElement('tr');
        grid.appendChild(tr)
        for (var j = 0; j < cols; j++) {
            td = document.createElement('td');
            tr.appendChild(td);
            td.style.width = Math.round(w / cols) + "px";
            td.style.height = Math.round(h / rows) + "px";
        }
    }
    grid.style.width = w + "px";
    grid.style.height = h + "px";
    grid.align = "center";
    document.body.appendChild(grid);
    var j = 1;
    var cell = $("td");
    cell.each(function() {
        if (j < cell.length) {
            $(this).attr("id", j + "");
            j++;
        } else {
            $(this).attr("id", "emptyCell");
        }
    });
    cellul = $("td");
    row = $("tr");
    cellLen = cellul.length;
    rowLen = row.length;
    colLen = cellLen / rowLen;
}
//cette fonction attribue une portion de vu de l'image a chaque cellul et l'affiche la grille
function showImage(image, imgW, imgH) {
    deplace = 0;
    $("#count").text(deplace + "");
    var cell = $("td");
    var k = 0; //cell index
    var rows = $("table tr").length;
    var cols = $("table tr:first-child td").length;

    for (var i = 0; i < rows; i++) {
        for (var j = 0; j < cols; j++) {
            if (k < cell.length - 1) {
                cell[k].style.backgroundImage = "url('" + image + "')";
                cell[k].style.backgroundSize = imgW + "px" + " " + imgH + "px";
                cell[k].style.backgroundPosition = "-" + Math.ceil(imgW / cols) * j + "px -" + Math.ceil(imgH / rows) * i + "px";
                cell[k].style.background.position = "absolute";
                k++;
            }
        }
    }
}
//cette fonction brasse les cellules
function shuffle(array) {
    var tmp, current, top = 0;
    if (rowLen == 2 && colLen == 2) { //la condition qui s'assure on a toujours une solution dans le cas ou on a une table 2x2
        var k = 0;
        for (var i = 0; i < 2; i++) {
            if (k < array.length - 1) {
                tmp = array[k];
                array[k] = array[k + 1];
                array[k + 1] = tmp;
                k++;
            } else {
                array[0] = array[k]
            }
        }
    } else {
        tmp,
        current,
        top = array.length;
        if (top)
            while (--top) {
                current = Math.floor(Math.random() * (top + 1));
                tmp = array[current];
                array[current] = array[top];
                array[top] = tmp;
            }
    }
    return array;
}
//cette fonction prend un tableau de td et invoque la methode shuffle pour brasser
$(document).ready(function() {
    $("#mix").click(function() {
        var cell = $("td");
        cell = shuffle(cell);
        updateGrid(cell);
        alert("Vous devez choisir une case a bouger!");
        deplace = 0;
        $("#count").text(deplace + "");
    });
});
//cette fonction permet de deplacer les cellules avec les cles de directions
$(document).ready(function() {
    $("body").on("keydown", function(event) {
        var cell = $("td");
        var IDs = [];
        $("table").find("td").each(function() { IDs.push(this.id); });
        var emptyPos = IDs.indexOf("emptyCell");
        var emptyCol = cell[emptyPos].cellIndex + 1;
        var emptyRow = cell[emptyPos].parentNode.rowIndex + 1;
        if (event.which != 37 && event.which != 38 && event.which != 39 && event.which != 40) {
            return;
        }
        //Go Right
        if (event.which == 39) {
            var cellLeftPos = emptyPos - 1;
            var cellLeftRow = cell[cellLeftPos].parentNode.rowIndex + 1;
            if (cellLeftRow == emptyRow) {
                var temp = cell[cellLeftPos];
                cell[cellLeftPos] = cell[emptyPos];
                cell[emptyPos] = temp;
                deplace++;
                $("#count").text(deplace + "");
            }
        }
        //Go Left     
        if (event.which == 37) {
            var cellRightPos = emptyPos + 1;
            var cellRightRow = cell[cellRightPos].parentNode.rowIndex + 1;
            if (cellRightRow == emptyRow) {
                var temp = cell[cellRightPos];
                cell[cellRightPos] = cell[emptyPos];
                cell[emptyPos] = temp;
                deplace++;
                $("#count").text(deplace + "");
            }
        }
        //Go Down     
        if (event.which == 40) {
            var cellUpPos = emptyPos - colLen;
            var cellUpCol = cell[cellUpPos].cellIndex + 1;
            if (cellUpCol == emptyCol) {
                var temp = cell[cellUpPos];
                cell[cellUpPos] = cell[emptyPos];
                cell[emptyPos] = temp;
                deplace++;
                $("#count").text(deplace + "");
            }
        }
        //Go Up     
        if (event.which == 38) {
            var cellDownPos = emptyPos + colLen;
            var cellDownCol = cell[cellDownPos].cellIndex + 1;
            if (cellDownCol == emptyCol) {
                var temp = cell[cellDownPos];
                cell[cellDownPos] = cell[emptyPos];
                cell[emptyPos] = temp;
                deplace++;
                $("#count").text(deplace + "");
            }
        }
        updateGrid(cell);
    });
});
//cette fonction permet de deplacer les cellules en cliquand au dessus
$(document).ready(function() {
    $("body").on("click", "td", function(e) {
        var cell = $("td");
        var IDs = [];
        $("table").find("td").each(function() { IDs.push(this.id); });
        var emptyPos = IDs.indexOf("emptyCell");
        var emptyCol = cell[emptyPos].cellIndex + 1;
        var emptyRow = cell[emptyPos].parentNode.rowIndex + 1;
        var currTdPos = IDs.indexOf(this.id);
        var currTdCol = this.cellIndex + 1;
        var currTdRow = this.parentNode.rowIndex + 1;
        if (currTdRow == emptyRow) {
            if (currTdPos < emptyPos) {
                for (var i = emptyPos; i > currTdPos; i--) {
                    var temp = cell[i - 1];
                    cell[i - 1] = cell[i];
                    cell[i] = temp;
                }
                deplace++;
                $("#count").text(deplace + "");
            }
            if (currTdPos > emptyPos) {
                for (var i = emptyPos; i < currTdPos; i++) {
                    var temp = cell[i + 1];
                    cell[i + 1] = cell[i];
                    cell[i] = temp;
                }
                deplace++;
                $("#count").text(deplace + "");
            }
        }
        if (currTdCol == emptyCol) {
            if (currTdPos < emptyPos) {
                for (var i = emptyPos; i > currTdPos; i = i - colLen) {
                    var temp = cell[i - colLen];
                    cell[i - colLen] = cell[i];
                    cell[i] = temp;
                }
                deplace++;
                $("#count").text(deplace + "");
            }
            if (currTdPos > emptyPos) {
                for (var i = emptyPos; i < currTdPos; i = i + colLen) {
                    var temp = cell[i + colLen];
                    cell[i + colLen] = cell[i];
                    cell[i] = temp;
                }
                deplace++;
                $("#count").text(deplace + "");
            }
        }
        e.stopPropagation();
        updateGrid(cell);
    });
});

//cette fonction mit a jour le grille une fois applee
function updateGrid(cell) {
    var k = 0;
    for (var i = 0; i < rowLen; i++) {
        for (var j = 0; j < colLen; j++) {
            row[i].appendChild(cell[k]);
            k++;
        }
    }
    if (moveCounter(deplace)) {
        alert("Felicitation! Vous avez gagne avec " + deplace + " deplacements");
        deplace = 0;
        $("#count").text(deplace + "");
    }
}
//cette fonction count le nombre de deplacement 
function moveCounter(deplacement) {
    var IDs = [];
    $("table").find("td").each(function() { IDs.push(this.id); });
    var refArr = []; //global
    for (var i = 0; i < IDs.length - 1; i++) {
        refArr[i] = i + 1 + "";
    }
    refArr[IDs.length - 1] = "emptyCell";
    for (var i = IDs.length; i--;) {
        if (IDs[i] !== refArr[i])
            return false;
    }
    return true;
}
//cette fonction affiche le numero de chaque case en cochant le check box defini
function showCellIndex(chkBx) {
    var cell = $("td");
    var IDs = [];
    $("table").find("td").each(function() { IDs.push(this.id); });
    if (chkBx.checked) {
        for (var i = 0; i < cell.length; i++) {
            if (IDs[i] != "emptyCell")
                cell[i].innerHTML = IDs[i];
        }
    } else {
        for (var i = 0; i < cell.length; i++) {
            cell[i].innerHTML = "";
        }
    }
}