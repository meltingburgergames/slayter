package slayter.map;

typedef Level = {
    identifier :String,
    iid :String,
    uid :Int,
    worldX :Int,
    worldY :Int,
    worldDepth :Int,
    pxWid :Int,
    pxHei :Int,
    layers :Array<Layer>,
}