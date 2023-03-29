pragma Warnings (Off);
pragma Ada_95;
with System;
with System.Parameters;
with System.Secondary_Stack;
package ada_main is

   gnat_argc : Integer;
   gnat_argv : System.Address;
   gnat_envp : System.Address;

   pragma Import (C, gnat_argc);
   pragma Import (C, gnat_argv);
   pragma Import (C, gnat_envp);

   gnat_exit_status : Integer;
   pragma Import (C, gnat_exit_status);

   GNAT_Version : constant String :=
                    "GNAT Version: 11.2.0" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_ephemeris_tools" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure adafinal;
   pragma Export (C, adafinal, "adafinal");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#cf9257fb#;
   pragma Export (C, u00001, "ephemeris_toolsB");
   u00002 : constant Version_32 := 16#66132de6#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#5fb136c1#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#5e074051#;
   pragma Export (C, u00004, "systemS");
   u00005 : constant Version_32 := 16#eca5ecae#;
   pragma Export (C, u00005, "system__memoryB");
   u00006 : constant Version_32 := 16#077a2665#;
   pragma Export (C, u00006, "system__memoryS");
   u00007 : constant Version_32 := 16#27bde6b3#;
   pragma Export (C, u00007, "ada__exceptionsB");
   u00008 : constant Version_32 := 16#023400c0#;
   pragma Export (C, u00008, "ada__exceptionsS");
   u00009 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00009, "adaS");
   u00010 : constant Version_32 := 16#51b6c352#;
   pragma Export (C, u00010, "ada__exceptions__last_chance_handlerB");
   u00011 : constant Version_32 := 16#2c60dc9e#;
   pragma Export (C, u00011, "ada__exceptions__last_chance_handlerS");
   u00012 : constant Version_32 := 16#adf22619#;
   pragma Export (C, u00012, "system__soft_linksB");
   u00013 : constant Version_32 := 16#c2be0dca#;
   pragma Export (C, u00013, "system__soft_linksS");
   u00014 : constant Version_32 := 16#bca68eac#;
   pragma Export (C, u00014, "system__secondary_stackB");
   u00015 : constant Version_32 := 16#afac77d5#;
   pragma Export (C, u00015, "system__secondary_stackS");
   u00016 : constant Version_32 := 16#896564a3#;
   pragma Export (C, u00016, "system__parametersB");
   u00017 : constant Version_32 := 16#1955849a#;
   pragma Export (C, u00017, "system__parametersS");
   u00018 : constant Version_32 := 16#ced09590#;
   pragma Export (C, u00018, "system__storage_elementsB");
   u00019 : constant Version_32 := 16#73c40a55#;
   pragma Export (C, u00019, "system__storage_elementsS");
   u00020 : constant Version_32 := 16#ce3e0e21#;
   pragma Export (C, u00020, "system__soft_links__initializeB");
   u00021 : constant Version_32 := 16#5697fc2b#;
   pragma Export (C, u00021, "system__soft_links__initializeS");
   u00022 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00022, "system__stack_checkingB");
   u00023 : constant Version_32 := 16#d0b82bb9#;
   pragma Export (C, u00023, "system__stack_checkingS");
   u00024 : constant Version_32 := 16#34742901#;
   pragma Export (C, u00024, "system__exception_tableB");
   u00025 : constant Version_32 := 16#053941ac#;
   pragma Export (C, u00025, "system__exception_tableS");
   u00026 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00026, "system__exceptionsB");
   u00027 : constant Version_32 := 16#36642da7#;
   pragma Export (C, u00027, "system__exceptionsS");
   u00028 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00028, "system__exceptions__machineB");
   u00029 : constant Version_32 := 16#bff81f32#;
   pragma Export (C, u00029, "system__exceptions__machineS");
   u00030 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00030, "system__exceptions_debugB");
   u00031 : constant Version_32 := 16#261dd12a#;
   pragma Export (C, u00031, "system__exceptions_debugS");
   u00032 : constant Version_32 := 16#ee8e331a#;
   pragma Export (C, u00032, "system__img_intS");
   u00033 : constant Version_32 := 16#01838199#;
   pragma Export (C, u00033, "system__tracebackB");
   u00034 : constant Version_32 := 16#1e8ab60a#;
   pragma Export (C, u00034, "system__tracebackS");
   u00035 : constant Version_32 := 16#1f08c83e#;
   pragma Export (C, u00035, "system__traceback_entriesB");
   u00036 : constant Version_32 := 16#78af9330#;
   pragma Export (C, u00036, "system__traceback_entriesS");
   u00037 : constant Version_32 := 16#a0281f47#;
   pragma Export (C, u00037, "system__traceback__symbolicB");
   u00038 : constant Version_32 := 16#9fa412cf#;
   pragma Export (C, u00038, "system__traceback__symbolicS");
   u00039 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00039, "ada__exceptions__tracebackB");
   u00040 : constant Version_32 := 16#6b52f2d4#;
   pragma Export (C, u00040, "ada__exceptions__tracebackS");
   u00041 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00041, "system__address_imageB");
   u00042 : constant Version_32 := 16#ffebdd6b#;
   pragma Export (C, u00042, "system__address_imageS");
   u00043 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00043, "system__wch_conB");
   u00044 : constant Version_32 := 16#457a6283#;
   pragma Export (C, u00044, "system__wch_conS");
   u00045 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00045, "system__wch_stwB");
   u00046 : constant Version_32 := 16#686b4e82#;
   pragma Export (C, u00046, "system__wch_stwS");
   u00047 : constant Version_32 := 16#1f681dab#;
   pragma Export (C, u00047, "system__wch_cnvB");
   u00048 : constant Version_32 := 16#4acdd870#;
   pragma Export (C, u00048, "system__wch_cnvS");
   u00049 : constant Version_32 := 16#edec285f#;
   pragma Export (C, u00049, "interfacesS");
   u00050 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00050, "system__wch_jisB");
   u00051 : constant Version_32 := 16#cabdc151#;
   pragma Export (C, u00051, "system__wch_jisS");
   u00052 : constant Version_32 := 16#17ee5feb#;
   pragma Export (C, u00052, "system__crtlS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  system%s
   --  system.img_int%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.traceback%s
   --  system.traceback%b
   --  system.secondary_stack%s
   --  system.standard_library%s
   --  ada.exceptions%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.soft_links%s
   --  system.wch_stw%s
   --  system.wch_stw%b
   --  ada.exceptions.last_chance_handler%s
   --  ada.exceptions.last_chance_handler%b
   --  ada.exceptions.traceback%s
   --  ada.exceptions.traceback%b
   --  system.address_image%s
   --  system.address_image%b
   --  system.exception_table%s
   --  system.exception_table%b
   --  system.exceptions%s
   --  system.exceptions%b
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.memory%s
   --  system.memory%b
   --  system.secondary_stack%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  system.standard_library%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  ephemeris_tools%b
   --  END ELABORATION ORDER

end ada_main;
