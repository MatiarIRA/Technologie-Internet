function init() { 
 
    document.getElementsByTagName('a').item(0).href="http://www.iro.umontreal.ca";     
    
document.getElementsByTagName('body').item(0).bgColor = "yellow";
    
var table = document.getElementsByTagName('table').item(0);
    
table.style.border="solid";
    table.style.backgroundColor="white";
    table.rows[1].style.backgroundColor="green";

}
