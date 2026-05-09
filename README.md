# Wacca_x86-64
ASM Source code and description for my patches!

============= Description =============== <br>
This is a compilation of 2 different patches injected at different offsets <br>
A special version of WaccaSongBrowser has beeen made to support these patches <br>

(1) <br>
ItemActivateTime under UnlockMusicTable and UnlockInfernoTable no longer make a music New, nor appear / disappear at a certain date! use bool below to make song new forever <br>
bValidCulture_h_Hans_CN_GeneralMember => new song <br>
bCollaboration => SugorokuBonus  (0 = none, 1 = blue gate bonus, 2 = yellow, 3 = red, 4 = max) <br>
TrainingLevel => MissionDiff (0 = normal and above, 1 = hard and above, 2 = exp and above, 3 = inferno only, 4 = disabled, 5 = MAX) <br>
song UniqueID above 3999 are NOT shown in All songs category.

(2) <br>
Title Categories are all empty now, so you can fill them in with this mod :p (use ALL then Title to find a song by title) <br>
bWaccaOriginal   => song category (for all diff) if not zero <br>
CopyrightMessage => song category (for all diff) if not zero, regex ^([0-9]*).*$ <br>
HashTag          => song category (for all diff) if not zero, regex ^([0-9]*).*$ <br>
WorkBuffer       => song category (for all diff) if not zero <br>
bingo6 => song category for normal  if not zero <br>
bingo7 => song category for hard    if not zero <br>
bingo8 => song category for expert  if not zero <br>
bingo9 => song category for inferno if not zero <br>
category is taken as modulo 256, and if it's superior to 61 it is skipped, so game will not crash with this mod even if you have bad data. <br>
song UniqueID above 3999 are NOT shown in Grade category.


; ================== (1) - asm source code ======================= <br>
; v6 at 140498d10 in dissassembly => assemble

; ============================ (2) - asm source code ========================== <br>
; v2 at 140498fb0 until 0x140499164 (do not touch xxx164)

==================== Instructions ===================== <br>
Compile my ASM Source code into bytecode using your favourite decompiler, <br>
then inject the bytes at the specific offset in Mercury-Win64-Shipping.exe <br>
 <br>
below, I shared the enum for categories, so you can assign categories of your choice to any song of the game!

```c
enum EMgmSelectGenreGroup : uint32_t
{
    Unknown = 0xffffffff,
    Recommend = 0x0,
    Newly = 0x1,
    All = 0x2,
    Genre_AnimePop = 0x3,
    Genre_Vocaloid = 0x4,
    Genre_Touhou = 0x5,
    Genre_D25 = 0x6,
    Genre_Variety = 0x7,
    Genre_Original = 0x8,
    Genre_TANOC = 0x9,
    Lv_1 = 0xa,
    Lv_2 = 0xb,
    Lv_3 = 0xc,
    Lv_4 = 0xd,
    Lv_5 = 0xe,
    Lv_5s = 0xf,
    Lv_6 = 0x10,
    Lv_6s = 0x11,
    Lv_7 = 0x12,
    Lv_7s = 0x13,
    Lv_8 = 0x14,
    Lv_8s = 0x15,
    Lv_9 = 0x16,
    Lv_9s = 0x17,
    Lv_10 = 0x18,
    Lv_10s = 0x19,
    Lv_11 = 0x1a,
    Lv_11s = 0x1b,
    Lv_12 = 0x1c,
    Lv_12s = 0x1d,
    Lv_13 = 0x1e,
    Lv_13s = 0x1f,
    Lv_14t = 0x20,
    Ver_Wacca = 0x21,
    Ver_WaccaS = 0x22,
    Ver_WaccaLily = 0x23,
    Ver_WaccaLilyR = 0x24,
    Ver_WaccaReverse = 0x25,
    Name_OJS_A = 0x26,
    Name_OJS_KA = 0x27,
    Name_OJS_SA = 0x28,
    Name_OJS_TA = 0x29,
    Name_OJS_NA = 0x2a,
    Name_OJS_HA = 0x2b,
    Name_OJS_MA = 0x2c,
    Name_OJS_YA = 0x2d,
    Name_OJS_RA = 0x2e,
    Name_OJS_WA = 0x2f,
    Name_Number = 0x30,
    Name_AO_AtoD = 0x31,
    Name_AO_EtoH = 0x32,
    Name_AO_ItoL = 0x33,
    Name_AO_MtoP = 0x34,
    Name_AO_QtoT = 0x35,
    Name_AO_UtoZ = 0x36,
    Clear_NotPlay = 0x37,
    Clear_Played = 0x38,
    Clear_Clear = 0x39,
    Clear_Missless = 0x3a,
    Clear_FullCombo = 0x3b,
    Clear_AllMarvelous = 0x3c,
    Favorite = 0x3d,
    Num = 0x3e
};

```
