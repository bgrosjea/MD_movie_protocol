XYZ=$1
start=$2
stride=$3
last=$4

natom=`head -1 $XYZ`

echo bash_arguments:
echo natom=$natom
echo XYZ=$XYZ
echo "Extracting steps: "$start:$stride:$last

gfortran ./XYZ_stride.f90

echo "inline inputs: natom XYZ start stride last"
echo "inline inputs: "$natom $XYZ $start $stride $last

./a.out $natom $XYZ $start $stride $last
temp=${XYZ/.xyz/}
mv XYZ_stride.out $temp\_stride\_$start\_$stride\_$last.xyz

echo ""
echo ""

