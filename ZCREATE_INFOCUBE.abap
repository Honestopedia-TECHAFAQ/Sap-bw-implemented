REPORT ZCREATE_INFOCUBE.

DATA: lt_characters TYPE TABLE OF RSCHAV,  " Table for characteristic fields
      ls_character  TYPE RSCHAV,           " Structure for characteristic field
      lt_keyfigures TYPE TABLE OF RSKFV,   " Table for key figure fields
      ls_keyfigure  TYPE RSKFV.            " Structure for key figure field

CONSTANTS: lc_infocube TYPE RSINFOCUBE VALUE 'ZCUBE_SALES'. " InfoCube name

* Define characteristics
ls_character-infoobject = 'SALES_ORDER'.
ls_character-attrnm     = 'CHAR'.
ls_character-length     = 10.
APPEND ls_character TO lt_characters.

* Define key figures
ls_keyfigure-infoobject = 'SALES_AMOUNT'.
ls_keyfigure-attrnm     = 'CURR'.
ls_keyfigure-length     = 15.
APPEND ls_keyfigure TO lt_keyfigures.

* Create InfoCube
CALL FUNCTION 'RSINF_CUBE_CREATE'
  EXPORTING
    i_infocube     = lc_infocube
    i_text         = 'Sales InfoCube'
  TABLES
    t_charfields   = lt_characters
    t_keyfigfields = lt_keyfigures
  EXCEPTIONS
    others         = 1.

IF sy-subrc = 0.
  WRITE: / 'InfoCube created successfully.'.
ELSE.
  WRITE: / 'Error creating InfoCube.'.
ENDIF.
