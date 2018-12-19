/**
 * Returns two values representing a tile position of the given model.
 * The values get stored in the given addresess in r5 and r6, 
 * typically the stack but not necessarily.
 */
int, int getEntityTileFromModel(int entityPtr) {
  modelPtr = load(entityPtr + 4)
  return getModelTile(modelPtr + 0x78)
}

0x000d3aec addiu r29,r29,0xffd8
0x000d3af0 sw r31,0x0018(r29)
0x000d3af4 sw r17,0x0014(r29)
0x000d3af8 sw r16,0x0010(r29)
0x000d3afc lw r2,0x0004(r4)
0x000d3b00 addu r17,r5,r0
0x000d3b04 addu r16,r6,r0
0x000d3b08 addiu r4,r2,0x0078
0x000d3b0c addiu r5,r29,0x0024
0x000d3b10 jal 0x000c0f28
0x000d3b14 addiu r6,r29,0x0026
0x000d3b18 lh r2,0x0024(r29)
0x000d3b1c nop
0x000d3b20 sb r2,0x0000(r17)
0x000d3b24 lh r2,0x0026(r29)
0x000d3b28 nop
0x000d3b2c sb r2,0x0000(r16)
0x000d3b30 lw r31,0x0018(r29)
0x000d3b34 lw r17,0x0014(r29)
0x000d3b38 lw r16,0x0010(r29)
0x000d3b3c jr r31
0x000d3b40 addiu r29,r29,0x0028
