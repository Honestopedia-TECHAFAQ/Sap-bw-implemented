REPORT ZCREATE_DATASOURCE.

DATA: lt_fields TYPE TABLE OF RSOLTPSOURCEFIELDS,   " Table for DataSource fields
      ls_field  TYPE RSOLTPSOURCEFIELDS.           " Structure for each field

* DataSource Name
CONSTANTS: lc_datasource TYPE RSOLTPSOURCE-OLTPSOURCE VALUE 'ZSALES_DS'.

* Clear the field list
CLEAR lt_fields.

* Define fields for the DataSource
ls_field-fieldname = 'SALES_ORDER'.
ls_field-datatype  = 'CHAR'.
ls_field-length    = 10.
APPEND ls_field TO lt_fields.

ls_field-fieldname = 'SALES_AMOUNT'.
ls_field-datatype  = 'CURR'.
ls_field-length    = 15.
APPEND ls_field TO lt_fields.

ls_field-fieldname = 'CURRENCY'.
ls_field-datatype  = 'CUKY'.
ls_field-length    = 5.
APPEND ls_field TO lt_fields.

* Call function to create DataSource
CALL FUNCTION 'RSO_DS_CREATE'
  EXPORTING
    i_datasource    = lc_datasource
    i_text          = 'Sales Data Source'
    i_s_data_source = 'S'              " Type of DataSource (Standard)
  TABLES
    t_fields        = lt_fields
  EXCEPTIONS
    others          = 1.

IF sy-subrc = 0.
  WRITE: / 'DataSource created successfully.'.
ELSE.
  WRITE: / 'Error creating DataSource.'.
ENDIF.
