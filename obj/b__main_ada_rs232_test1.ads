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
                    "GNAT Version: 9.3.0" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_main_ada_rs232_test1" & ASCII.NUL;
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
   u00001 : constant Version_32 := 16#e17ca0cb#;
   pragma Export (C, u00001, "main_ada_rs232_test1B");
   u00002 : constant Version_32 := 16#050ff2f0#;
   pragma Export (C, u00002, "system__standard_libraryB");
   u00003 : constant Version_32 := 16#4113f22b#;
   pragma Export (C, u00003, "system__standard_libraryS");
   u00004 : constant Version_32 := 16#76789da1#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#9762c9f2#;
   pragma Export (C, u00005, "ada__exceptionsB");
   u00006 : constant Version_32 := 16#585ef86b#;
   pragma Export (C, u00006, "ada__exceptionsS");
   u00007 : constant Version_32 := 16#5726abed#;
   pragma Export (C, u00007, "ada__exceptions__last_chance_handlerB");
   u00008 : constant Version_32 := 16#41e5552e#;
   pragma Export (C, u00008, "ada__exceptions__last_chance_handlerS");
   u00009 : constant Version_32 := 16#4635ec04#;
   pragma Export (C, u00009, "systemS");
   u00010 : constant Version_32 := 16#ae860117#;
   pragma Export (C, u00010, "system__soft_linksB");
   u00011 : constant Version_32 := 16#0336e7b2#;
   pragma Export (C, u00011, "system__soft_linksS");
   u00012 : constant Version_32 := 16#f32b4133#;
   pragma Export (C, u00012, "system__secondary_stackB");
   u00013 : constant Version_32 := 16#03a1141d#;
   pragma Export (C, u00013, "system__secondary_stackS");
   u00014 : constant Version_32 := 16#86dbf443#;
   pragma Export (C, u00014, "system__parametersB");
   u00015 : constant Version_32 := 16#0ed9b82f#;
   pragma Export (C, u00015, "system__parametersS");
   u00016 : constant Version_32 := 16#ced09590#;
   pragma Export (C, u00016, "system__storage_elementsB");
   u00017 : constant Version_32 := 16#6bf6a600#;
   pragma Export (C, u00017, "system__storage_elementsS");
   u00018 : constant Version_32 := 16#75bf515c#;
   pragma Export (C, u00018, "system__soft_links__initializeB");
   u00019 : constant Version_32 := 16#5697fc2b#;
   pragma Export (C, u00019, "system__soft_links__initializeS");
   u00020 : constant Version_32 := 16#41837d1e#;
   pragma Export (C, u00020, "system__stack_checkingB");
   u00021 : constant Version_32 := 16#c88a87ec#;
   pragma Export (C, u00021, "system__stack_checkingS");
   u00022 : constant Version_32 := 16#34742901#;
   pragma Export (C, u00022, "system__exception_tableB");
   u00023 : constant Version_32 := 16#1b9b8546#;
   pragma Export (C, u00023, "system__exception_tableS");
   u00024 : constant Version_32 := 16#ce4af020#;
   pragma Export (C, u00024, "system__exceptionsB");
   u00025 : constant Version_32 := 16#2e5681f2#;
   pragma Export (C, u00025, "system__exceptionsS");
   u00026 : constant Version_32 := 16#69416224#;
   pragma Export (C, u00026, "system__exceptions__machineB");
   u00027 : constant Version_32 := 16#d27d9682#;
   pragma Export (C, u00027, "system__exceptions__machineS");
   u00028 : constant Version_32 := 16#aa0563fc#;
   pragma Export (C, u00028, "system__exceptions_debugB");
   u00029 : constant Version_32 := 16#38bf15c0#;
   pragma Export (C, u00029, "system__exceptions_debugS");
   u00030 : constant Version_32 := 16#6c2f8802#;
   pragma Export (C, u00030, "system__img_intB");
   u00031 : constant Version_32 := 16#44ee0cc6#;
   pragma Export (C, u00031, "system__img_intS");
   u00032 : constant Version_32 := 16#39df8c17#;
   pragma Export (C, u00032, "system__tracebackB");
   u00033 : constant Version_32 := 16#181732c0#;
   pragma Export (C, u00033, "system__tracebackS");
   u00034 : constant Version_32 := 16#9ed49525#;
   pragma Export (C, u00034, "system__traceback_entriesB");
   u00035 : constant Version_32 := 16#466e1a74#;
   pragma Export (C, u00035, "system__traceback_entriesS");
   u00036 : constant Version_32 := 16#448e9548#;
   pragma Export (C, u00036, "system__traceback__symbolicB");
   u00037 : constant Version_32 := 16#c84061d1#;
   pragma Export (C, u00037, "system__traceback__symbolicS");
   u00038 : constant Version_32 := 16#179d7d28#;
   pragma Export (C, u00038, "ada__containersS");
   u00039 : constant Version_32 := 16#701f9d88#;
   pragma Export (C, u00039, "ada__exceptions__tracebackB");
   u00040 : constant Version_32 := 16#20245e75#;
   pragma Export (C, u00040, "ada__exceptions__tracebackS");
   u00041 : constant Version_32 := 16#5ab55268#;
   pragma Export (C, u00041, "interfacesS");
   u00042 : constant Version_32 := 16#769e25e6#;
   pragma Export (C, u00042, "interfaces__cB");
   u00043 : constant Version_32 := 16#467817d8#;
   pragma Export (C, u00043, "interfaces__cS");
   u00044 : constant Version_32 := 16#e865e681#;
   pragma Export (C, u00044, "system__bounded_stringsB");
   u00045 : constant Version_32 := 16#31c8cd1d#;
   pragma Export (C, u00045, "system__bounded_stringsS");
   u00046 : constant Version_32 := 16#0062635e#;
   pragma Export (C, u00046, "system__crtlS");
   u00047 : constant Version_32 := 16#bba79bcb#;
   pragma Export (C, u00047, "system__dwarf_linesB");
   u00048 : constant Version_32 := 16#9a78d181#;
   pragma Export (C, u00048, "system__dwarf_linesS");
   u00049 : constant Version_32 := 16#5b4659fa#;
   pragma Export (C, u00049, "ada__charactersS");
   u00050 : constant Version_32 := 16#8f637df8#;
   pragma Export (C, u00050, "ada__characters__handlingB");
   u00051 : constant Version_32 := 16#3b3f6154#;
   pragma Export (C, u00051, "ada__characters__handlingS");
   u00052 : constant Version_32 := 16#4b7bb96a#;
   pragma Export (C, u00052, "ada__characters__latin_1S");
   u00053 : constant Version_32 := 16#e6d4fa36#;
   pragma Export (C, u00053, "ada__stringsS");
   u00054 : constant Version_32 := 16#96df1a3f#;
   pragma Export (C, u00054, "ada__strings__mapsB");
   u00055 : constant Version_32 := 16#1e526bec#;
   pragma Export (C, u00055, "ada__strings__mapsS");
   u00056 : constant Version_32 := 16#d68fb8f1#;
   pragma Export (C, u00056, "system__bit_opsB");
   u00057 : constant Version_32 := 16#0765e3a3#;
   pragma Export (C, u00057, "system__bit_opsS");
   u00058 : constant Version_32 := 16#72b39087#;
   pragma Export (C, u00058, "system__unsigned_typesS");
   u00059 : constant Version_32 := 16#92f05f13#;
   pragma Export (C, u00059, "ada__strings__maps__constantsS");
   u00060 : constant Version_32 := 16#a0d3d22b#;
   pragma Export (C, u00060, "system__address_imageB");
   u00061 : constant Version_32 := 16#e7d9713e#;
   pragma Export (C, u00061, "system__address_imageS");
   u00062 : constant Version_32 := 16#ec78c2bf#;
   pragma Export (C, u00062, "system__img_unsB");
   u00063 : constant Version_32 := 16#ed47ac70#;
   pragma Export (C, u00063, "system__img_unsS");
   u00064 : constant Version_32 := 16#d7aac20c#;
   pragma Export (C, u00064, "system__ioB");
   u00065 : constant Version_32 := 16#d8771b4b#;
   pragma Export (C, u00065, "system__ioS");
   u00066 : constant Version_32 := 16#f790d1ef#;
   pragma Export (C, u00066, "system__mmapB");
   u00067 : constant Version_32 := 16#7c445363#;
   pragma Export (C, u00067, "system__mmapS");
   u00068 : constant Version_32 := 16#92d882c5#;
   pragma Export (C, u00068, "ada__io_exceptionsS");
   u00069 : constant Version_32 := 16#0cdaa54a#;
   pragma Export (C, u00069, "system__mmap__os_interfaceB");
   u00070 : constant Version_32 := 16#82f29877#;
   pragma Export (C, u00070, "system__mmap__os_interfaceS");
   u00071 : constant Version_32 := 16#834dfe5e#;
   pragma Export (C, u00071, "system__mmap__unixS");
   u00072 : constant Version_32 := 16#fa90b46b#;
   pragma Export (C, u00072, "system__os_libB");
   u00073 : constant Version_32 := 16#4542b55d#;
   pragma Export (C, u00073, "system__os_libS");
   u00074 : constant Version_32 := 16#ec4d5631#;
   pragma Export (C, u00074, "system__case_utilB");
   u00075 : constant Version_32 := 16#79e05a50#;
   pragma Export (C, u00075, "system__case_utilS");
   u00076 : constant Version_32 := 16#2a8e89ad#;
   pragma Export (C, u00076, "system__stringsB");
   u00077 : constant Version_32 := 16#2623c091#;
   pragma Export (C, u00077, "system__stringsS");
   u00078 : constant Version_32 := 16#5a3f5337#;
   pragma Export (C, u00078, "system__object_readerB");
   u00079 : constant Version_32 := 16#82413105#;
   pragma Export (C, u00079, "system__object_readerS");
   u00080 : constant Version_32 := 16#1a74a354#;
   pragma Export (C, u00080, "system__val_lliB");
   u00081 : constant Version_32 := 16#dc110aa4#;
   pragma Export (C, u00081, "system__val_lliS");
   u00082 : constant Version_32 := 16#afdbf393#;
   pragma Export (C, u00082, "system__val_lluB");
   u00083 : constant Version_32 := 16#0841c7f5#;
   pragma Export (C, u00083, "system__val_lluS");
   u00084 : constant Version_32 := 16#269742a9#;
   pragma Export (C, u00084, "system__val_utilB");
   u00085 : constant Version_32 := 16#ea955afa#;
   pragma Export (C, u00085, "system__val_utilS");
   u00086 : constant Version_32 := 16#d7bf3f29#;
   pragma Export (C, u00086, "system__exception_tracesB");
   u00087 : constant Version_32 := 16#62eacc9e#;
   pragma Export (C, u00087, "system__exception_tracesS");
   u00088 : constant Version_32 := 16#8c33a517#;
   pragma Export (C, u00088, "system__wch_conB");
   u00089 : constant Version_32 := 16#5d48ced6#;
   pragma Export (C, u00089, "system__wch_conS");
   u00090 : constant Version_32 := 16#9721e840#;
   pragma Export (C, u00090, "system__wch_stwB");
   u00091 : constant Version_32 := 16#7059e2d7#;
   pragma Export (C, u00091, "system__wch_stwS");
   u00092 : constant Version_32 := 16#a831679c#;
   pragma Export (C, u00092, "system__wch_cnvB");
   u00093 : constant Version_32 := 16#52ff7425#;
   pragma Export (C, u00093, "system__wch_cnvS");
   u00094 : constant Version_32 := 16#ece6fdb6#;
   pragma Export (C, u00094, "system__wch_jisB");
   u00095 : constant Version_32 := 16#d28f6d04#;
   pragma Export (C, u00095, "system__wch_jisS");
   u00096 : constant Version_32 := 16#a3db8081#;
   pragma Export (C, u00096, "ada__strings__unboundedB");
   u00097 : constant Version_32 := 16#f39c7224#;
   pragma Export (C, u00097, "ada__strings__unboundedS");
   u00098 : constant Version_32 := 16#60da0992#;
   pragma Export (C, u00098, "ada__strings__searchB");
   u00099 : constant Version_32 := 16#c1ab8667#;
   pragma Export (C, u00099, "ada__strings__searchS");
   u00100 : constant Version_32 := 16#d398a95f#;
   pragma Export (C, u00100, "ada__tagsB");
   u00101 : constant Version_32 := 16#12a0afb8#;
   pragma Export (C, u00101, "ada__tagsS");
   u00102 : constant Version_32 := 16#796f31f1#;
   pragma Export (C, u00102, "system__htableB");
   u00103 : constant Version_32 := 16#c2f75fee#;
   pragma Export (C, u00103, "system__htableS");
   u00104 : constant Version_32 := 16#089f5cd0#;
   pragma Export (C, u00104, "system__string_hashB");
   u00105 : constant Version_32 := 16#60a93490#;
   pragma Export (C, u00105, "system__string_hashS");
   u00106 : constant Version_32 := 16#acee74ad#;
   pragma Export (C, u00106, "system__compare_array_unsigned_8B");
   u00107 : constant Version_32 := 16#ef369d89#;
   pragma Export (C, u00107, "system__compare_array_unsigned_8S");
   u00108 : constant Version_32 := 16#a8025f3c#;
   pragma Export (C, u00108, "system__address_operationsB");
   u00109 : constant Version_32 := 16#55395237#;
   pragma Export (C, u00109, "system__address_operationsS");
   u00110 : constant Version_32 := 16#2e260032#;
   pragma Export (C, u00110, "system__storage_pools__subpoolsB");
   u00111 : constant Version_32 := 16#cc5a1856#;
   pragma Export (C, u00111, "system__storage_pools__subpoolsS");
   u00112 : constant Version_32 := 16#d96e3c40#;
   pragma Export (C, u00112, "system__finalization_mastersB");
   u00113 : constant Version_32 := 16#1dc9d5ce#;
   pragma Export (C, u00113, "system__finalization_mastersS");
   u00114 : constant Version_32 := 16#7268f812#;
   pragma Export (C, u00114, "system__img_boolB");
   u00115 : constant Version_32 := 16#b3ec9def#;
   pragma Export (C, u00115, "system__img_boolS");
   u00116 : constant Version_32 := 16#86c56e5a#;
   pragma Export (C, u00116, "ada__finalizationS");
   u00117 : constant Version_32 := 16#10558b11#;
   pragma Export (C, u00117, "ada__streamsB");
   u00118 : constant Version_32 := 16#67e31212#;
   pragma Export (C, u00118, "ada__streamsS");
   u00119 : constant Version_32 := 16#95817ed8#;
   pragma Export (C, u00119, "system__finalization_rootB");
   u00120 : constant Version_32 := 16#09c79f94#;
   pragma Export (C, u00120, "system__finalization_rootS");
   u00121 : constant Version_32 := 16#6d4d969a#;
   pragma Export (C, u00121, "system__storage_poolsB");
   u00122 : constant Version_32 := 16#65d872a9#;
   pragma Export (C, u00122, "system__storage_poolsS");
   u00123 : constant Version_32 := 16#84042202#;
   pragma Export (C, u00123, "system__storage_pools__subpools__finalizationB");
   u00124 : constant Version_32 := 16#fe2f4b3a#;
   pragma Export (C, u00124, "system__storage_pools__subpools__finalizationS");
   u00125 : constant Version_32 := 16#020a3f4d#;
   pragma Export (C, u00125, "system__atomic_countersB");
   u00126 : constant Version_32 := 16#f269c189#;
   pragma Export (C, u00126, "system__atomic_countersS");
   u00127 : constant Version_32 := 16#039168f8#;
   pragma Export (C, u00127, "system__stream_attributesB");
   u00128 : constant Version_32 := 16#8bc30a4e#;
   pragma Export (C, u00128, "system__stream_attributesS");
   u00129 : constant Version_32 := 16#927a893f#;
   pragma Export (C, u00129, "ada__text_ioB");
   u00130 : constant Version_32 := 16#5194351e#;
   pragma Export (C, u00130, "ada__text_ioS");
   u00131 : constant Version_32 := 16#73d2d764#;
   pragma Export (C, u00131, "interfaces__c_streamsB");
   u00132 : constant Version_32 := 16#b1330297#;
   pragma Export (C, u00132, "interfaces__c_streamsS");
   u00133 : constant Version_32 := 16#71ac0ba7#;
   pragma Export (C, u00133, "system__file_ioB");
   u00134 : constant Version_32 := 16#e1440d61#;
   pragma Export (C, u00134, "system__file_ioS");
   u00135 : constant Version_32 := 16#bbaa76ac#;
   pragma Export (C, u00135, "system__file_control_blockS");
   u00136 : constant Version_32 := 16#2ac31c89#;
   pragma Export (C, u00136, "interfaces__c__extensionsS");
   u00137 : constant Version_32 := 16#b9f5847d#;
   pragma Export (C, u00137, "pkg_aada_rs232B");
   u00138 : constant Version_32 := 16#df8a215b#;
   pragma Export (C, u00138, "pkg_aada_rs232S");
   u00139 : constant Version_32 := 16#a3f2ee4b#;
   pragma Export (C, u00139, "pkg_ada_rs232S");
   u00140 : constant Version_32 := 16#894fb81a#;
   pragma Export (C, u00140, "pkg_ada_dtstampB");
   u00141 : constant Version_32 := 16#25638e1e#;
   pragma Export (C, u00141, "pkg_ada_dtstampS");
   u00142 : constant Version_32 := 16#9a2e29aa#;
   pragma Export (C, u00142, "ada__calendarB");
   u00143 : constant Version_32 := 16#c4f07049#;
   pragma Export (C, u00143, "ada__calendarS");
   u00144 : constant Version_32 := 16#51f2d040#;
   pragma Export (C, u00144, "system__os_primitivesB");
   u00145 : constant Version_32 := 16#41c889f2#;
   pragma Export (C, u00145, "system__os_primitivesS");
   u00146 : constant Version_32 := 16#10f667b3#;
   pragma Export (C, u00146, "ada__calendar__formattingB");
   u00147 : constant Version_32 := 16#f87a094f#;
   pragma Export (C, u00147, "ada__calendar__formattingS");
   u00148 : constant Version_32 := 16#e3cca715#;
   pragma Export (C, u00148, "ada__calendar__time_zonesB");
   u00149 : constant Version_32 := 16#f21593b3#;
   pragma Export (C, u00149, "ada__calendar__time_zonesS");
   u00150 : constant Version_32 := 16#d763507a#;
   pragma Export (C, u00150, "system__val_intB");
   u00151 : constant Version_32 := 16#0e90c63b#;
   pragma Export (C, u00151, "system__val_intS");
   u00152 : constant Version_32 := 16#1d9142a4#;
   pragma Export (C, u00152, "system__val_unsB");
   u00153 : constant Version_32 := 16#621b7dbc#;
   pragma Export (C, u00153, "system__val_unsS");
   u00154 : constant Version_32 := 16#c2ca0511#;
   pragma Export (C, u00154, "system__val_realB");
   u00155 : constant Version_32 := 16#b81c9b15#;
   pragma Export (C, u00155, "system__val_realS");
   u00156 : constant Version_32 := 16#b2a569d2#;
   pragma Export (C, u00156, "system__exn_llfB");
   u00157 : constant Version_32 := 16#fa4b57d8#;
   pragma Export (C, u00157, "system__exn_llfS");
   u00158 : constant Version_32 := 16#42a257f7#;
   pragma Export (C, u00158, "system__fat_llfS");
   u00159 : constant Version_32 := 16#1b28662b#;
   pragma Export (C, u00159, "system__float_controlB");
   u00160 : constant Version_32 := 16#a6c9af38#;
   pragma Export (C, u00160, "system__float_controlS");
   u00161 : constant Version_32 := 16#16458a73#;
   pragma Export (C, u00161, "system__powten_tableS");
   u00162 : constant Version_32 := 16#4fc9bc76#;
   pragma Export (C, u00162, "ada__command_lineB");
   u00163 : constant Version_32 := 16#3cdef8c9#;
   pragma Export (C, u00163, "ada__command_lineS");
   u00164 : constant Version_32 := 16#eb4fc41d#;
   pragma Export (C, u00164, "ada__real_timeB");
   u00165 : constant Version_32 := 16#69ea8064#;
   pragma Export (C, u00165, "ada__real_timeS");
   u00166 : constant Version_32 := 16#c05c480c#;
   pragma Export (C, u00166, "system__taskingB");
   u00167 : constant Version_32 := 16#d15fc24c#;
   pragma Export (C, u00167, "system__taskingS");
   u00168 : constant Version_32 := 16#c333d44f#;
   pragma Export (C, u00168, "system__task_primitivesS");
   u00169 : constant Version_32 := 16#02d5b781#;
   pragma Export (C, u00169, "system__os_interfaceB");
   u00170 : constant Version_32 := 16#8b11eeee#;
   pragma Export (C, u00170, "system__os_interfaceS");
   u00171 : constant Version_32 := 16#ff1f7771#;
   pragma Export (C, u00171, "system__linuxS");
   u00172 : constant Version_32 := 16#198dbba9#;
   pragma Export (C, u00172, "system__os_constantsS");
   u00173 : constant Version_32 := 16#3d3b214a#;
   pragma Export (C, u00173, "system__task_primitives__operationsB");
   u00174 : constant Version_32 := 16#69ee9f34#;
   pragma Export (C, u00174, "system__task_primitives__operationsS");
   u00175 : constant Version_32 := 16#71c5de81#;
   pragma Export (C, u00175, "system__interrupt_managementB");
   u00176 : constant Version_32 := 16#24a21b5f#;
   pragma Export (C, u00176, "system__interrupt_managementS");
   u00177 : constant Version_32 := 16#f65595cf#;
   pragma Export (C, u00177, "system__multiprocessorsB");
   u00178 : constant Version_32 := 16#7e997377#;
   pragma Export (C, u00178, "system__multiprocessorsS");
   u00179 : constant Version_32 := 16#375a3ef7#;
   pragma Export (C, u00179, "system__task_infoB");
   u00180 : constant Version_32 := 16#1c069690#;
   pragma Export (C, u00180, "system__task_infoS");
   u00181 : constant Version_32 := 16#f2eb7df6#;
   pragma Export (C, u00181, "system__tasking__debugB");
   u00182 : constant Version_32 := 16#aea59d30#;
   pragma Export (C, u00182, "system__tasking__debugS");
   u00183 : constant Version_32 := 16#fd83e873#;
   pragma Export (C, u00183, "system__concat_2B");
   u00184 : constant Version_32 := 16#44953bd4#;
   pragma Export (C, u00184, "system__concat_2S");
   u00185 : constant Version_32 := 16#2b70b149#;
   pragma Export (C, u00185, "system__concat_3B");
   u00186 : constant Version_32 := 16#4d45b0a1#;
   pragma Export (C, u00186, "system__concat_3S");
   u00187 : constant Version_32 := 16#273384e4#;
   pragma Export (C, u00187, "system__img_enum_newB");
   u00188 : constant Version_32 := 16#2779eac4#;
   pragma Export (C, u00188, "system__img_enum_newS");
   u00189 : constant Version_32 := 16#9dca6636#;
   pragma Export (C, u00189, "system__img_lliB");
   u00190 : constant Version_32 := 16#577ab9d5#;
   pragma Export (C, u00190, "system__img_lliS");
   u00191 : constant Version_32 := 16#6ec3c867#;
   pragma Export (C, u00191, "system__stack_usageB");
   u00192 : constant Version_32 := 16#3a3ac346#;
   pragma Export (C, u00192, "system__stack_usageS");
   u00193 : constant Version_32 := 16#2353cf5b#;
   pragma Export (C, u00193, "ada__real_time__delaysB");
   u00194 : constant Version_32 := 16#0a5c26d7#;
   pragma Export (C, u00194, "ada__real_time__delaysS");
   u00195 : constant Version_32 := 16#fe1ffede#;
   pragma Export (C, u00195, "ada__strings__boundedB");
   u00196 : constant Version_32 := 16#89c18940#;
   pragma Export (C, u00196, "ada__strings__boundedS");
   u00197 : constant Version_32 := 16#7ec26662#;
   pragma Export (C, u00197, "ada__strings__superboundedB");
   u00198 : constant Version_32 := 16#da6addee#;
   pragma Export (C, u00198, "ada__strings__superboundedS");
   u00199 : constant Version_32 := 16#adb6d201#;
   pragma Export (C, u00199, "ada__strings__fixedB");
   u00200 : constant Version_32 := 16#a86b22b3#;
   pragma Export (C, u00200, "ada__strings__fixedS");
   u00201 : constant Version_32 := 16#27d2953a#;
   pragma Export (C, u00201, "ada__strings__unbounded__text_ioB");
   u00202 : constant Version_32 := 16#2e5d93ef#;
   pragma Export (C, u00202, "ada__strings__unbounded__text_ioS");
   u00203 : constant Version_32 := 16#276453b7#;
   pragma Export (C, u00203, "system__img_lldB");
   u00204 : constant Version_32 := 16#b517e56d#;
   pragma Export (C, u00204, "system__img_lldS");
   u00205 : constant Version_32 := 16#bd3715ff#;
   pragma Export (C, u00205, "system__img_decB");
   u00206 : constant Version_32 := 16#e818e5df#;
   pragma Export (C, u00206, "system__img_decS");
   u00207 : constant Version_32 := 16#2323a8af#;
   pragma Export (C, u00207, "system__memoryB");
   u00208 : constant Version_32 := 16#1f488a30#;
   pragma Export (C, u00208, "system__memoryS");

   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  ada.characters%s
   --  ada.characters.latin_1%s
   --  interfaces%s
   --  system%s
   --  system.address_operations%s
   --  system.address_operations%b
   --  system.atomic_counters%s
   --  system.atomic_counters%b
   --  system.exn_llf%s
   --  system.exn_llf%b
   --  system.float_control%s
   --  system.float_control%b
   --  system.img_bool%s
   --  system.img_bool%b
   --  system.img_enum_new%s
   --  system.img_enum_new%b
   --  system.img_int%s
   --  system.img_int%b
   --  system.img_dec%s
   --  system.img_dec%b
   --  system.img_lli%s
   --  system.img_lli%b
   --  system.img_lld%s
   --  system.img_lld%b
   --  system.io%s
   --  system.io%b
   --  system.os_primitives%s
   --  system.os_primitives%b
   --  system.parameters%s
   --  system.parameters%b
   --  system.crtl%s
   --  interfaces.c_streams%s
   --  interfaces.c_streams%b
   --  system.powten_table%s
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.stack_checking%s
   --  system.stack_checking%b
   --  system.stack_usage%s
   --  system.stack_usage%b
   --  system.string_hash%s
   --  system.string_hash%b
   --  system.htable%s
   --  system.htable%b
   --  system.strings%s
   --  system.strings%b
   --  system.traceback_entries%s
   --  system.traceback_entries%b
   --  system.unsigned_types%s
   --  system.img_uns%s
   --  system.img_uns%b
   --  system.wch_con%s
   --  system.wch_con%b
   --  system.wch_jis%s
   --  system.wch_jis%b
   --  system.wch_cnv%s
   --  system.wch_cnv%b
   --  system.compare_array_unsigned_8%s
   --  system.compare_array_unsigned_8%b
   --  system.concat_2%s
   --  system.concat_2%b
   --  system.concat_3%s
   --  system.concat_3%b
   --  system.traceback%s
   --  system.traceback%b
   --  system.case_util%s
   --  system.standard_library%s
   --  system.exception_traces%s
   --  ada.exceptions%s
   --  system.wch_stw%s
   --  system.val_util%s
   --  system.val_llu%s
   --  system.val_lli%s
   --  system.os_lib%s
   --  system.bit_ops%s
   --  ada.characters.handling%s
   --  ada.exceptions.traceback%s
   --  system.secondary_stack%s
   --  system.case_util%b
   --  system.address_image%s
   --  system.bounded_strings%s
   --  system.soft_links%s
   --  system.exception_table%s
   --  system.exception_table%b
   --  ada.io_exceptions%s
   --  ada.strings%s
   --  ada.containers%s
   --  system.exceptions%s
   --  system.exceptions%b
   --  ada.exceptions.last_chance_handler%s
   --  system.exceptions_debug%s
   --  system.exceptions_debug%b
   --  system.exception_traces%b
   --  system.memory%s
   --  system.memory%b
   --  system.wch_stw%b
   --  system.val_util%b
   --  system.val_llu%b
   --  system.val_lli%b
   --  system.os_lib%b
   --  system.bit_ops%b
   --  ada.strings.maps%s
   --  ada.strings.maps.constants%s
   --  ada.characters.handling%b
   --  interfaces.c%s
   --  ada.exceptions.traceback%b
   --  system.exceptions.machine%s
   --  system.exceptions.machine%b
   --  system.secondary_stack%b
   --  system.address_image%b
   --  system.bounded_strings%b
   --  system.soft_links.initialize%s
   --  system.soft_links.initialize%b
   --  system.soft_links%b
   --  ada.exceptions.last_chance_handler%b
   --  system.standard_library%b
   --  system.mmap%s
   --  ada.strings.maps%b
   --  interfaces.c%b
   --  system.object_reader%s
   --  system.dwarf_lines%s
   --  system.dwarf_lines%b
   --  system.mmap.unix%s
   --  system.mmap.os_interface%s
   --  system.mmap%b
   --  system.traceback.symbolic%s
   --  system.traceback.symbolic%b
   --  ada.exceptions%b
   --  system.object_reader%b
   --  system.mmap.os_interface%b
   --  ada.command_line%s
   --  ada.command_line%b
   --  ada.strings.search%s
   --  ada.strings.search%b
   --  ada.strings.fixed%s
   --  ada.strings.fixed%b
   --  ada.strings.superbounded%s
   --  ada.strings.superbounded%b
   --  ada.strings.bounded%s
   --  ada.strings.bounded%b
   --  ada.tags%s
   --  ada.tags%b
   --  ada.streams%s
   --  ada.streams%b
   --  interfaces.c.extensions%s
   --  system.fat_llf%s
   --  system.file_control_block%s
   --  system.finalization_root%s
   --  system.finalization_root%b
   --  ada.finalization%s
   --  system.file_io%s
   --  system.file_io%b
   --  system.linux%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.os_constants%s
   --  system.os_interface%s
   --  system.os_interface%b
   --  system.storage_pools%s
   --  system.storage_pools%b
   --  system.finalization_masters%s
   --  system.finalization_masters%b
   --  system.storage_pools.subpools%s
   --  system.storage_pools.subpools.finalization%s
   --  system.storage_pools.subpools%b
   --  system.storage_pools.subpools.finalization%b
   --  system.stream_attributes%s
   --  system.stream_attributes%b
   --  ada.strings.unbounded%s
   --  ada.strings.unbounded%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.interrupt_management%s
   --  system.interrupt_management%b
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking.debug%s
   --  system.tasking%b
   --  system.task_primitives.operations%b
   --  system.tasking.debug%b
   --  system.val_real%s
   --  system.val_real%b
   --  system.val_uns%s
   --  system.val_uns%b
   --  system.val_int%s
   --  system.val_int%b
   --  ada.calendar%s
   --  ada.calendar%b
   --  ada.calendar.time_zones%s
   --  ada.calendar.time_zones%b
   --  ada.calendar.formatting%s
   --  ada.calendar.formatting%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.real_time.delays%s
   --  ada.real_time.delays%b
   --  ada.text_io%s
   --  ada.text_io%b
   --  ada.strings.unbounded.text_io%s
   --  ada.strings.unbounded.text_io%b
   --  pkg_ada_dtstamp%s
   --  pkg_ada_dtstamp%b
   --  pkg_ada_rs232%s
   --  pkg_aada_rs232%s
   --  pkg_aada_rs232%b
   --  main_ada_rs232_test1%b
   --  END ELABORATION ORDER

end ada_main;
