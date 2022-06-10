$fs = 0.1;
$fn = 200;

length = 115;
width = 84; 
height = 2; 
radius = 10;
doubleRadius = 2*radius;

translate([10,10,0])
{
difference()
{   
    roundedBox(length, width, height);
    translate([1,1,1])
        {
   
        roundedBox(length-2, width-2, height-1);
        }
    }
}




module roundedBox(length, width, height, radius)
{

        cube (size=[length-doubleRadius, width-doubleRadius, height]);
     

}