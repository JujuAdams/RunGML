# RunGML Manual

	## About

	Version: 1.3.0

	Homepage: https://github.com/sdelaughter/RunGML

## Operators & *Aliases*
[*False*](#false), [*GM_build_date*](#gm_build_date), [*GM_build_type*](#gm_build_type), [*GM_runtime_version*](#gm_runtime_version), [*GM_version*](#gm_version), [*NaN*](#nan), [*RunGML_Version*](#version), [*True*](#true), [*a*](#array), [add](#add), [alias](#alias), [all](#all), [and](#and), [angle](#angle), [animcurvetype_catmullrom](#animcurvetype_catmullrom), [animcurvetype_linear](#animcurvetype_linear), [application_surface](#application_surface), [approach](#approach), [arctan2](#arctan2), [array](#array), [asset](#asset), [asset_animationcurve](#asset_animationcurve), [asset_font](#asset_font), [asset_object](#asset_object), [asset_path](#asset_path), [asset_room](#asset_room), [asset_script](#asset_script), [asset_sequence](#asset_sequence), [asset_shader](#asset_shader), [asset_sound](#asset_sound), [asset_sprite](#asset_sprite), [asset_tiles](#asset_tiles), [asset_timeline](#asset_timeline), [asset_type](#asset_type), [asset_unknown](#asset_unknown), [async_load](#async_load), [audio_3d](#audio_3d), [audio_falloff_exponent_distance](#audio_falloff_exponent_distance), [audio_falloff_exponent_distance_clamped](#audio_falloff_exponent_distance_clamped), [audio_falloff_exponent_distance_scaled](#audio_falloff_exponent_distance_scaled), [audio_falloff_inverse_distance](#audio_falloff_inverse_distance), [audio_falloff_inverse_distance_clamped](#audio_falloff_inverse_distance_clamped), [audio_falloff_linear_distance](#audio_falloff_linear_distance), [audio_falloff_linear_distance_clamped](#audio_falloff_linear_distance_clamped), [audio_falloff_none](#audio_falloff_none), [audio_mono](#audio_mono), [audio_stereo](#audio_stereo), [bboxkind_diamond](#bboxkind_diamond), [bboxkind_ellipse](#bboxkind_ellipse), [bboxkind_precise](#bboxkind_precise), [bboxkind_rectangular](#bboxkind_rectangular), [bboxmode_automatic](#bboxmode_automatic), [bboxmode_fullimage](#bboxmode_fullimage), [bboxmode_manual](#bboxmode_manual), [bm_add](#bm_add), [bm_dest_alpha](#bm_dest_alpha), [bm_dest_color](#bm_dest_color), [bm_dest_colour](#bm_dest_colour), [bm_inv_dest_alpha](#bm_inv_dest_alpha), [bm_inv_dest_color](#bm_inv_dest_color), [bm_inv_src_alpha](#bm_inv_src_alpha), [bm_inv_src_color](#bm_inv_src_color), [bm_inv_src_colour](#bm_inv_src_colour), [bm_max](#bm_max), [bm_normal](#bm_normal), [bm_one](#bm_one), [bm_src_alpha](#bm_src_alpha), [bm_src_alpha_sat](#bm_src_alpha_sat), [bm_src_color](#bm_src_color), [bm_src_colour](#bm_src_colour), [bm_subtract](#bm_subtract), [bm_zero](#bm_zero), [browser_chrome](#browser_chrome), [browser_edge](#browser_edge), [browser_firefox](#browser_firefox), [browser_ie](#browser_ie), [browser_ie_mobile](#browser_ie_mobile), [browser_not_a_browser](#browser_not_a_browser), [browser_opera](#browser_opera), [browser_safari](#browser_safari), [browser_safari_mobile](#browser_safari_mobile), [browser_unknown](#browser_unknown), [browser_windows_store](#browser_windows_store), [buffer_bool](#buffer_bool), [buffer_f16](#buffer_f16), [buffer_f32](#buffer_f32), [buffer_f64](#buffer_f64), [buffer_fast](#buffer_fast), [buffer_fixed](#buffer_fixed), [buffer_grow](#buffer_grow), [buffer_s16](#buffer_s16), [buffer_s32](#buffer_s32), [buffer_s8](#buffer_s8), [buffer_seek_end](#buffer_seek_end), [buffer_seek_relative](#buffer_seek_relative), [buffer_seek_start](#buffer_seek_start), [buffer_string](#buffer_string), [buffer_text](#buffer_text), [buffer_u16](#buffer_u16), [buffer_u32](#buffer_u32), [buffer_u64](#buffer_u64), [buffer_u8](#buffer_u8), [buffer_vbuffer](#buffer_vbuffer), [buffer_wrap](#buffer_wrap), [c_aqua](#c_aqua), [c_black](#c_black), [c_blue](#c_blue), [c_dkgray](#c_dkgray), [c_fuchsia](#c_fuchsia), [c_gray](#c_gray), [c_green](#c_green), [c_lime](#c_lime), [c_ltgray](#c_ltgray), [c_maroon](#c_maroon), [c_navy](#c_navy), [c_olive](#c_olive), [c_orange](#c_orange), [c_purple](#c_purple), [c_red](#c_red), [c_silver](#c_silver), [c_teal](#c_teal), [c_white](#c_white), [c_yellow](#c_yellow), [cat](#cat), [choose](#choose), [clear](#clear), [cmpfunc_always](#cmpfunc_always), [cmpfunc_equal](#cmpfunc_equal), [cmpfunc_greater](#cmpfunc_greater), [cmpfunc_greaterequal](#cmpfunc_greaterequal), [cmpfunc_less](#cmpfunc_less), [cmpfunc_lessequal](#cmpfunc_lessequal), [cmpfunc_never](#cmpfunc_never), [cmpfunc_notequal](#cmpfunc_notequal), [color](#color), [color_inv](#color_inv), [color_inv_hue](#color_inv_hue), [color_merge](#color_merge), [color_rand](#color_rand), [console](#console), [cos](#cos), [cr_appstart](#cr_appstart), [cr_arrow](#cr_arrow), [cr_beam](#cr_beam), [cr_cross](#cr_cross), [cr_default](#cr_default), [cr_drag](#cr_drag), [cr_handpoint](#cr_handpoint), [cr_hourglass](#cr_hourglass), [cr_none](#cr_none), [cr_size_all](#cr_size_all), [cr_size_nesw](#cr_size_nesw), [cr_size_ns](#cr_size_ns), [cr_size_nwse](#cr_size_nwse), [cr_size_we](#cr_size_we), [cr_uparrow](#cr_uparrow), [create](#create), [cull_clockwise](#cull_clockwise), [cull_counterclockwise](#cull_counterclockwise), [cull_noculling](#cull_noculling), [current](#current), [current_day](#current_day), [current_hour](#current_hour), [current_minute](#current_minute), [current_month](#current_month), [current_second](#current_second), [current_time](#current_time), [current_year](#current_year), [cursor](#cursor), [cursor_sprite](#cursor_sprite), [date_get](#date_get), [datestring](#datestring), [datetime](#datetime), [debug](#debug), [dec](#dec), [delta](#delta), [delta_time](#delta_time), [destroy](#destroy), [device_emulator](#device_emulator), [device_ios_ipad](#device_ios_ipad), [device_ios_ipad_retina](#device_ios_ipad_retina), [device_ios_iphone](#device_ios_iphone), [device_ios_iphone5](#device_ios_iphone5), [device_ios_iphone6](#device_ios_iphone6), [device_ios_iphone6plus](#device_ios_iphone6plus), [device_ios_iphone_retina](#device_ios_iphone_retina), [device_ios_unknown](#device_ios_unknown), [device_tablet](#device_tablet), [display_gui_h](#display_gui_h), [display_gui_w](#display_gui_w), [display_h](#display_h), [display_landscape](#display_landscape), [display_landscape_flipped](#display_landscape_flipped), [display_portrait](#display_portrait), [display_portrait_flipped](#display_portrait_flipped), [display_w](#display_w), [div](#div), [*divide*](#div), [dll_cdecl](#dll_cdecl), [dll_stdcall](#dll_stdcall), [do](#do), [do_here](#do_here), [dot](#dot), [dot3](#dot3), [dot3_norm](#dot3_norm), [dot_norm](#dot_norm), [draw_alpha](#draw_alpha), [draw_circle](#draw_circle), [draw_color](#draw_color), [draw_ellipse](#draw_ellipse), [draw_font](#draw_font), [draw_format](#draw_format), [draw_halign](#draw_halign), [draw_line](#draw_line), [draw_point](#draw_point), [draw_rect](#draw_rect), [draw_self](#draw_self), [draw_valign](#draw_valign), [ds_type_grid](#ds_type_grid), [ds_type_list](#ds_type_list), [ds_type_map](#ds_type_map), [ds_type_priority](#ds_type_priority), [ds_type_queue](#ds_type_queue), [ds_type_stack](#ds_type_stack), [e](#e), [ef_cloud](#ef_cloud), [ef_ellipse](#ef_ellipse), [ef_explosion](#ef_explosion), [ef_firework](#ef_firework), [ef_flare](#ef_flare), [ef_rain](#ef_rain), [ef_ring](#ef_ring), [ef_smoke](#ef_smoke), [ef_smokeup](#ef_smokeup), [ef_snow](#ef_snow), [ef_spark](#ef_spark), [ef_star](#ef_star), [eq](#eq), [ev_alarm](#ev_alarm), [ev_animation_end](#ev_animation_end), [ev_async_audio_playback](#ev_async_audio_playback), [ev_async_audio_recording](#ev_async_audio_recording), [ev_async_dialog](#ev_async_dialog), [ev_async_push_notification](#ev_async_push_notification), [ev_async_save_load](#ev_async_save_load), [ev_async_social](#ev_async_social), [ev_async_system_event](#ev_async_system_event), [ev_async_web](#ev_async_web), [ev_async_web_cloud](#ev_async_web_cloud), [ev_async_web_iap](#ev_async_web_iap), [ev_async_web_image_load](#ev_async_web_image_load), [ev_async_web_networking](#ev_async_web_networking), [ev_async_web_steam](#ev_async_web_steam), [ev_boundary](#ev_boundary), [ev_boundary_view0](#ev_boundary_view0), [ev_boundary_view1](#ev_boundary_view1), [ev_boundary_view2](#ev_boundary_view2), [ev_boundary_view3](#ev_boundary_view3), [ev_boundary_view4](#ev_boundary_view4), [ev_boundary_view5](#ev_boundary_view5), [ev_boundary_view6](#ev_boundary_view6), [ev_boundary_view7](#ev_boundary_view7), [ev_broadcast_message](#ev_broadcast_message), [ev_cleanup](#ev_cleanup), [ev_collision](#ev_collision), [ev_create](#ev_create), [ev_destroy](#ev_destroy), [ev_draw](#ev_draw), [ev_draw_begin](#ev_draw_begin), [ev_draw_end](#ev_draw_end), [ev_draw_post](#ev_draw_post), [ev_draw_pre](#ev_draw_pre), [ev_end_of_path](#ev_end_of_path), [ev_game_end](#ev_game_end), [ev_game_start](#ev_game_start), [ev_gesture](#ev_gesture), [ev_gesture_double_tap](#ev_gesture_double_tap), [ev_gesture_drag_end](#ev_gesture_drag_end), [ev_gesture_drag_start](#ev_gesture_drag_start), [ev_gesture_dragging](#ev_gesture_dragging), [ev_gesture_flick](#ev_gesture_flick), [ev_gesture_pinch_end](#ev_gesture_pinch_end), [ev_gesture_pinch_in](#ev_gesture_pinch_in), [ev_gesture_pinch_out](#ev_gesture_pinch_out), [ev_gesture_pinch_start](#ev_gesture_pinch_start), [ev_gesture_rotate_end](#ev_gesture_rotate_end), [ev_gesture_rotate_start](#ev_gesture_rotate_start), [ev_gesture_rotating](#ev_gesture_rotating), [ev_gesture_tap](#ev_gesture_tap), [ev_global_gesture_double_tap](#ev_global_gesture_double_tap), [ev_global_gesture_drag_end](#ev_global_gesture_drag_end), [ev_global_gesture_drag_start](#ev_global_gesture_drag_start), [ev_global_gesture_dragging](#ev_global_gesture_dragging), [ev_global_gesture_flick](#ev_global_gesture_flick), [ev_global_gesture_pinch_end](#ev_global_gesture_pinch_end), [ev_global_gesture_pinch_in](#ev_global_gesture_pinch_in), [ev_global_gesture_pinch_out](#ev_global_gesture_pinch_out), [ev_global_gesture_pinch_start](#ev_global_gesture_pinch_start), [ev_global_gesture_rotate_end](#ev_global_gesture_rotate_end), [ev_global_gesture_rotate_start](#ev_global_gesture_rotate_start), [ev_global_gesture_rotating](#ev_global_gesture_rotating), [ev_global_gesture_tap](#ev_global_gesture_tap), [ev_global_left_button](#ev_global_left_button), [ev_global_left_press](#ev_global_left_press), [ev_global_left_release](#ev_global_left_release), [ev_global_middle_button](#ev_global_middle_button), [ev_global_middle_press](#ev_global_middle_press), [ev_global_middle_release](#ev_global_middle_release), [ev_global_right_button](#ev_global_right_button), [ev_global_right_press](#ev_global_right_press), [ev_global_right_release](#ev_global_right_release), [ev_gui](#ev_gui), [ev_gui_begin](#ev_gui_begin), [ev_gui_end](#ev_gui_end), [ev_keyboard](#ev_keyboard), [ev_keypress](#ev_keypress), [ev_keyrelease](#ev_keyrelease), [ev_left_button](#ev_left_button), [ev_left_press](#ev_left_press), [ev_left_release](#ev_left_release), [ev_middle_button](#ev_middle_button), [ev_middle_press](#ev_middle_press), [ev_middle_release](#ev_middle_release), [ev_mouse](#ev_mouse), [ev_mouse_enter](#ev_mouse_enter), [ev_mouse_leave](#ev_mouse_leave), [ev_mouse_wheel_down](#ev_mouse_wheel_down), [ev_mouse_wheel_up](#ev_mouse_wheel_up), [ev_no_button](#ev_no_button), [ev_no_more_health](#ev_no_more_health), [ev_no_more_lives](#ev_no_more_lives), [ev_other](#ev_other), [ev_outside](#ev_outside), [ev_outside_view0](#ev_outside_view0), [ev_outside_view1](#ev_outside_view1), [ev_outside_view2](#ev_outside_view2), [ev_outside_view3](#ev_outside_view3), [ev_outside_view4](#ev_outside_view4), [ev_outside_view5](#ev_outside_view5), [ev_outside_view6](#ev_outside_view6), [ev_outside_view7](#ev_outside_view7), [ev_pre_create](#ev_pre_create), [ev_right_button](#ev_right_button), [ev_right_press](#ev_right_press), [ev_right_release](#ev_right_release), [ev_room_end](#ev_room_end), [ev_room_start](#ev_room_start), [ev_step](#ev_step), [ev_step_begin](#ev_step_begin), [ev_step_end](#ev_step_end), [ev_step_normal](#ev_step_normal), [ev_user0](#ev_user0), [ev_user1](#ev_user1), [ev_user10](#ev_user10), [ev_user11](#ev_user11), [ev_user12](#ev_user12), [ev_user13](#ev_user13), [ev_user14](#ev_user14), [ev_user15](#ev_user15), [ev_user2](#ev_user2), [ev_user3](#ev_user3), [ev_user4](#ev_user4), [ev_user5](#ev_user5), [ev_user6](#ev_user6), [ev_user7](#ev_user7), [ev_user8](#ev_user8), [ev_user9](#ev_user9), [event_data](#event_data), [event_number](#event_number), [event_type](#event_type), [example](#example), [exec](#exec), [export](#export), [fa_archive](#fa_archive), [fa_bottom](#fa_bottom), [fa_center](#fa_center), [fa_directory](#fa_directory), [fa_hidden](#fa_hidden), [fa_left](#fa_left), [fa_middle](#fa_middle), [fa_readonly](#fa_readonly), [fa_right](#fa_right), [fa_sysfile](#fa_sysfile), [fa_top](#fa_top), [fa_volumeid](#fa_volumeid), [false](#false), [for](#for), [fps](#fps), [fps_real](#fps_real), [fullscreen](#fullscreen), [*g*](#global), [game_display_name](#game_display_name), [game_project_name](#game_project_name), [game_save_id](#game_save_id), [game_speed](#game_speed), [game_time](#game_time), [gamespeed_fps](#gamespeed_fps), [gamespeed_microseconds](#gamespeed_microseconds), [geq](#geq), [global](#global), [gm_build_date](#gm_build_date), [gm_build_type](#gm_build_type), [gm_runtime_version](#gm_runtime_version), [gm_version](#gm_version), [gp_axis_acceleration_x](#gp_axis_acceleration_x), [gp_axis_acceleration_y](#gp_axis_acceleration_y), [gp_axis_acceleration_z](#gp_axis_acceleration_z), [gp_axis_angular_velocity_x](#gp_axis_angular_velocity_x), [gp_axis_angular_velocity_y](#gp_axis_angular_velocity_y), [gp_axis_angular_velocity_z](#gp_axis_angular_velocity_z), [gp_axis_orientation_w](#gp_axis_orientation_w), [gp_axis_orientation_x](#gp_axis_orientation_x), [gp_axis_orientation_y](#gp_axis_orientation_y), [gp_axis_orientation_z](#gp_axis_orientation_z), [gp_axislh](#gp_axislh), [gp_axislv](#gp_axislv), [gp_axisrh](#gp_axisrh), [gp_axisrv](#gp_axisrv), [gp_face1](#gp_face1), [gp_face2](#gp_face2), [gp_face3](#gp_face3), [gp_face4](#gp_face4), [gp_padd](#gp_padd), [gp_padl](#gp_padl), [gp_padr](#gp_padr), [gp_padu](#gp_padu), [gp_select](#gp_select), [gp_shoulderl](#gp_shoulderl), [gp_shoulderlb](#gp_shoulderlb), [gp_shoulderr](#gp_shoulderr), [gp_shoulderrb](#gp_shoulderrb), [gp_start](#gp_start), [gp_stickl](#gp_stickl), [gp_stickr](#gp_stickr), [gt](#gt), [help](#help), [hsv](#hsv), [*i*](#inst), [if](#if), [import](#import), [in](#in), [inc](#inc), [infinity](#infinity), [inst](#inst), [instance_count](#instance_count), [iter](#iter), [iters](#iters), [kbv_autocapitalize_characters](#kbv_autocapitalize_characters), [kbv_autocapitalize_none](#kbv_autocapitalize_none), [kbv_autocapitalize_sentences](#kbv_autocapitalize_sentences), [kbv_autocapitalize_words](#kbv_autocapitalize_words), [kbv_returnkey_continue](#kbv_returnkey_continue), [kbv_returnkey_default](#kbv_returnkey_default), [kbv_returnkey_done](#kbv_returnkey_done), [kbv_returnkey_emergency](#kbv_returnkey_emergency), [kbv_returnkey_go](#kbv_returnkey_go), [kbv_returnkey_google](#kbv_returnkey_google), [kbv_returnkey_join](#kbv_returnkey_join), [kbv_returnkey_next](#kbv_returnkey_next), [kbv_returnkey_route](#kbv_returnkey_route), [kbv_returnkey_search](#kbv_returnkey_search), [kbv_returnkey_send](#kbv_returnkey_send), [kbv_returnkey_yahoo](#kbv_returnkey_yahoo), [kbv_type_ascii](#kbv_type_ascii), [kbv_type_default](#kbv_type_default), [kbv_type_email](#kbv_type_email), [kbv_type_numbers](#kbv_type_numbers), [kbv_type_phone](#kbv_type_phone), [kbv_type_phone_name](#kbv_type_phone_name), [kbv_type_url](#kbv_type_url), [*l*](#list), [last](#last), [layerelementtype_background](#layerelementtype_background), [layerelementtype_instance](#layerelementtype_instance), [layerelementtype_oldtilemap](#layerelementtype_oldtilemap), [layerelementtype_particlesystem](#layerelementtype_particlesystem), [layerelementtype_sequence](#layerelementtype_sequence), [layerelementtype_sprite](#layerelementtype_sprite), [layerelementtype_tile](#layerelementtype_tile), [layerelementtype_tilemap](#layerelementtype_tilemap), [layerelementtype_undefined](#layerelementtype_undefined), [len](#len), [lendir_x](#lendir_x), [lendir_y](#lendir_y), [leq](#leq), [lighttype_dir](#lighttype_dir), [lighttype_point](#lighttype_point), [list](#list), [log](#log), [lt](#lt), [manual](#manual), [map_range](#map_range), [matrix_projection](#matrix_projection), [matrix_view](#matrix_view), [matrix_world](#matrix_world), [mb_any](#mb_any), [mb_left](#mb_left), [mb_middle](#mb_middle), [mb_none](#mb_none), [mb_right](#mb_right), [mb_side1](#mb_side1), [mb_side2](#mb_side2), [mip_markedonly](#mip_markedonly), [mip_off](#mip_off), [mip_on](#mip_on), [mod](#mod), [mouse_button](#mouse_button), [mouse_lastbutton](#mouse_lastbutton), [mouse_x](#mouse_x), [mouse_y](#mouse_y), [mult](#mult), [*multiply*](#mult), [nan](#nan), [near](#near), [near_cursor](#near_cursor), [neq](#neq), [network_config_avoid_time_wait](#network_config_avoid_time_wait), [network_config_connect_timeout](#network_config_connect_timeout), [network_config_disable_reliable_udp](#network_config_disable_reliable_udp), [network_config_enable_reliable_udp](#network_config_enable_reliable_udp), [network_config_use_non_blocking_socket](#network_config_use_non_blocking_socket), [network_config_websocket_protocol](#network_config_websocket_protocol), [network_connect_blocking](#network_connect_blocking), [network_connect_nonblocking](#network_connect_nonblocking), [network_connect_none](#network_connect_none), [network_send_binary](#network_send_binary), [network_send_text](#network_send_text), [network_socket_bluetooth](#network_socket_bluetooth), [network_socket_tcp](#network_socket_tcp), [network_socket_udp](#network_socket_udp), [network_socket_ws](#network_socket_ws), [network_type_connect](#network_type_connect), [network_type_data](#network_type_data), [network_type_disconnect](#network_type_disconnect), [network_type_down](#network_type_down), [network_type_non_blocking_connect](#network_type_non_blocking_connect), [network_type_up](#network_type_up), [network_type_up_failed](#network_type_up_failed), [nineslice_blank](#nineslice_blank), [nineslice_bottom](#nineslice_bottom), [nineslice_center](#nineslice_center), [nineslice_centre](#nineslice_centre), [nineslice_hide](#nineslice_hide), [nineslice_left](#nineslice_left), [nineslice_mirror](#nineslice_mirror), [nineslice_repeat](#nineslice_repeat), [nineslice_right](#nineslice_right), [nineslice_stretch](#nineslice_stretch), [nineslice_top](#nineslice_top), [noone](#noone), [not](#not), [nth](#nth), [*o*](#object), [object](#object), [op_count](#op_count), [op_list](#op_list), [op_names](#op_names), [op_search](#op_search), [or](#or), [os_android](#os_android), [os_browser](#os_browser), [os_device](#os_device), [os_gdk](#os_gdk), [os_gxgames](#os_gxgames), [os_ios](#os_ios), [os_linux](#os_linux), [os_macosx](#os_macosx), [os_operagx](#os_operagx), [os_permission_denied](#os_permission_denied), [os_permission_denied_dont_request](#os_permission_denied_dont_request), [os_permission_granted](#os_permission_granted), [os_ps4](#os_ps4), [os_ps5](#os_ps5), [os_switch](#os_switch), [os_tvos](#os_tvos), [os_type](#os_type), [os_unknown](#os_unknown), [os_version](#os_version), [os_windows](#os_windows), [os_xboxseriesxs](#os_xboxseriesxs), [out](#out), [*p*](#parent), [parent](#parent), [pass](#pass), [path_action_continue](#path_action_continue), [path_action_restart](#path_action_restart), [path_action_reverse](#path_action_reverse), [path_action_stop](#path_action_stop), [phi](#phi), [phy_debug_render_aabb](#phy_debug_render_aabb), [phy_debug_render_collision_pairs](#phy_debug_render_collision_pairs), [phy_debug_render_coms](#phy_debug_render_coms), [phy_debug_render_core_shapes](#phy_debug_render_core_shapes), [phy_debug_render_joints](#phy_debug_render_joints), [phy_debug_render_obb](#phy_debug_render_obb), [phy_debug_render_shapes](#phy_debug_render_shapes), [phy_joint_anchor_1_x](#phy_joint_anchor_1_x), [phy_joint_anchor_1_y](#phy_joint_anchor_1_y), [phy_joint_anchor_2_x](#phy_joint_anchor_2_x), [phy_joint_anchor_2_y](#phy_joint_anchor_2_y), [phy_joint_angle](#phy_joint_angle), [phy_joint_angle_limits](#phy_joint_angle_limits), [phy_joint_damping_ratio](#phy_joint_damping_ratio), [phy_joint_frequency](#phy_joint_frequency), [phy_joint_length_1](#phy_joint_length_1), [phy_joint_length_2](#phy_joint_length_2), [phy_joint_lower_angle_limit](#phy_joint_lower_angle_limit), [phy_joint_max_force](#phy_joint_max_force), [phy_joint_max_length](#phy_joint_max_length), [phy_joint_max_motor_force](#phy_joint_max_motor_force), [phy_joint_max_motor_torque](#phy_joint_max_motor_torque), [phy_joint_max_torque](#phy_joint_max_torque), [phy_joint_motor_force](#phy_joint_motor_force), [phy_joint_motor_speed](#phy_joint_motor_speed), [phy_joint_motor_torque](#phy_joint_motor_torque), [phy_joint_reaction_force_x](#phy_joint_reaction_force_x), [phy_joint_reaction_force_y](#phy_joint_reaction_force_y), [phy_joint_reaction_torque](#phy_joint_reaction_torque), [phy_joint_speed](#phy_joint_speed), [phy_joint_translation](#phy_joint_translation), [phy_joint_upper_angle_limit](#phy_joint_upper_angle_limit), [phy_particle_data_flag_category](#phy_particle_data_flag_category), [phy_particle_data_flag_color](#phy_particle_data_flag_color), [phy_particle_data_flag_colour](#phy_particle_data_flag_colour), [phy_particle_data_flag_position](#phy_particle_data_flag_position), [phy_particle_data_flag_typeflags](#phy_particle_data_flag_typeflags), [phy_particle_data_flag_velocity](#phy_particle_data_flag_velocity), [phy_particle_flag_colormixing](#phy_particle_flag_colormixing), [phy_particle_flag_colourmixing](#phy_particle_flag_colourmixing), [phy_particle_flag_elastic](#phy_particle_flag_elastic), [phy_particle_flag_powder](#phy_particle_flag_powder), [phy_particle_flag_spring](#phy_particle_flag_spring), [phy_particle_flag_tensile](#phy_particle_flag_tensile), [phy_particle_flag_viscous](#phy_particle_flag_viscous), [phy_particle_flag_wall](#phy_particle_flag_wall), [phy_particle_flag_water](#phy_particle_flag_water), [phy_particle_flag_zombie](#phy_particle_flag_zombie), [phy_particle_group_flag_rigid](#phy_particle_group_flag_rigid), [phy_particle_group_flag_solid](#phy_particle_group_flag_solid), [pi](#pi), [point_dir](#point_dir), [point_dist](#point_dist), [pointer_invalid](#pointer_invalid), [pointer_null](#pointer_null), [pow](#pow), [pr_linelist](#pr_linelist), [pr_linestrip](#pr_linestrip), [pr_pointlist](#pr_pointlist), [pr_trianglefan](#pr_trianglefan), [pr_trianglelist](#pr_trianglelist), [pr_trianglestrip](#pr_trianglestrip), [print](#print), [prog](#prog), [program_directory](#program_directory), [ps_distr_gaussian](#ps_distr_gaussian), [ps_distr_invgaussian](#ps_distr_invgaussian), [ps_distr_linear](#ps_distr_linear), [ps_shape_diamond](#ps_shape_diamond), [ps_shape_ellipse](#ps_shape_ellipse), [ps_shape_line](#ps_shape_line), [ps_shape_rectangle](#ps_shape_rectangle), [pt_shape_circle](#pt_shape_circle), [pt_shape_cloud](#pt_shape_cloud), [pt_shape_disk](#pt_shape_disk), [pt_shape_explosion](#pt_shape_explosion), [pt_shape_flare](#pt_shape_flare), [pt_shape_line](#pt_shape_line), [pt_shape_pixel](#pt_shape_pixel), [pt_shape_ring](#pt_shape_ring), [pt_shape_smoke](#pt_shape_smoke), [pt_shape_snow](#pt_shape_snow), [pt_shape_spark](#pt_shape_spark), [pt_shape_sphere](#pt_shape_sphere), [pt_shape_square](#pt_shape_square), [pt_shape_star](#pt_shape_star), [*q*](#quit), [quit](#quit), [*r*](#reference), [rand](#rand), [rand_int](#rand_int), [rand_seed](#rand_seed), [rec_cancel](#rec_cancel), [rec_delete](#rec_delete), [rec_pause](#rec_pause), [rec_preview](#rec_preview), [rec_replay](#rec_replay), [rec_resume](#rec_resume), [rec_start](#rec_start), [rec_stop](#rec_stop), [reference](#reference), [reference_parent](#reference_parent), [repeat](#repeat), [restart](#restart), [rgb](#rgb), [rickroll](#rickroll), [room](#room), [room_first](#room_first), [room_h](#room_h), [room_last](#room_last), [room_next](#room_next), [room_w](#room_w), [*rp*](#reference_parent), [run](#run), [run_clean](#run_clean), [runfile](#runfile), [runprog](#runprog), [*s*](#struct), [screenshot](#screenshot), [seqaudiokey_loop](#seqaudiokey_loop), [seqaudiokey_oneshot](#seqaudiokey_oneshot), [seqdir_left](#seqdir_left), [seqdir_right](#seqdir_right), [seqinterpolation_assign](#seqinterpolation_assign), [seqinterpolation_lerp](#seqinterpolation_lerp), [seqplay_loop](#seqplay_loop), [seqplay_oneshot](#seqplay_oneshot), [seqplay_pingpong](#seqplay_pingpong), [seqtracktype_audio](#seqtracktype_audio), [seqtracktype_bool](#seqtracktype_bool), [seqtracktype_clipmask](#seqtracktype_clipmask), [seqtracktype_clipmask_mask](#seqtracktype_clipmask_mask), [seqtracktype_clipmask_subject](#seqtracktype_clipmask_subject), [seqtracktype_color](#seqtracktype_color), [seqtracktype_colour](#seqtracktype_colour), [seqtracktype_empty](#seqtracktype_empty), [seqtracktype_graphic](#seqtracktype_graphic), [seqtracktype_group](#seqtracktype_group), [seqtracktype_instance](#seqtracktype_instance), [seqtracktype_message](#seqtracktype_message), [seqtracktype_moment](#seqtracktype_moment), [seqtracktype_real](#seqtracktype_real), [seqtracktype_sequence](#seqtracktype_sequence), [seqtracktype_spriteframes](#seqtracktype_spriteframes), [seqtracktype_string](#seqtracktype_string), [shader](#shader), [shader_reset](#shader_reset), [sin](#sin), [sprite](#sprite), [spritespeed_framespergameframe](#spritespeed_framespergameframe), [spritespeed_framespersecond](#spritespeed_framespersecond), [*str*](#string), [string](#string), [struct](#struct), [struct_keys](#struct_keys), [sub](#sub), [*subtract*](#sub), [switch](#switch), [*t*](#this), [tan](#tan), [tau](#tau), [temp_directory](#temp_directory), [*test_alias*](#test_operator), [*test_alias_alias*](#test_operator), [test_constant](#Test), [test_operator](#test_operator), [tf_anisotropic](#tf_anisotropic), [tf_linear](#tf_linear), [tf_point](#tf_point), [this](#this), [tile_flip](#tile_flip), [tile_index_mask](#tile_index_mask), [tile_mirror](#tile_mirror), [tile_rotate](#tile_rotate), [time_source_expire_after](#time_source_expire_after), [time_source_expire_nearest](#time_source_expire_nearest), [time_source_game](#time_source_game), [time_source_global](#time_source_global), [time_source_state_active](#time_source_state_active), [time_source_state_initial](#time_source_state_initial), [time_source_state_paused](#time_source_state_paused), [time_source_state_stopped](#time_source_state_stopped), [time_source_units_frames](#time_source_units_frames), [time_source_units_seconds](#time_source_units_seconds), [timezone_local](#timezone_local), [timezone_utc](#timezone_utc), [tm_countvsyncs](#tm_countvsyncs), [tm_sleep](#tm_sleep), [true](#true), [ty_real](#ty_real), [ty_string](#ty_string), [type](#type), [undefined](#undefined), [update](#update), [url_open](#url_open), [*v*](#var), [var](#var), [version](#version), [vertex_type_color](#vertex_type_color), [vertex_type_colour](#vertex_type_colour), [vertex_type_float1](#vertex_type_float1), [vertex_type_float2](#vertex_type_float2), [vertex_type_float3](#vertex_type_float3), [vertex_type_float4](#vertex_type_float4), [vertex_type_ubyte4](#vertex_type_ubyte4), [vertex_usage_binormal](#vertex_usage_binormal), [vertex_usage_blendindices](#vertex_usage_blendindices), [vertex_usage_blendweight](#vertex_usage_blendweight), [vertex_usage_color](#vertex_usage_color), [vertex_usage_colour](#vertex_usage_colour), [vertex_usage_depth](#vertex_usage_depth), [vertex_usage_fog](#vertex_usage_fog), [vertex_usage_normal](#vertex_usage_normal), [vertex_usage_position](#vertex_usage_position), [vertex_usage_psize](#vertex_usage_psize), [vertex_usage_sample](#vertex_usage_sample), [vertex_usage_tangent](#vertex_usage_tangent), [vertex_usage_texcoord](#vertex_usage_texcoord), [vertex_usage_textcoord](#vertex_usage_textcoord), [video_format_rgba](#video_format_rgba), [video_format_yuv](#video_format_yuv), [video_status_closed](#video_status_closed), [video_status_paused](#video_status_paused), [video_status_playing](#video_status_playing), [video_status_preparing](#video_status_preparing), [view_current](#view_current), [vk_add](#vk_add), [vk_alt](#vk_alt), [vk_anykey](#vk_anykey), [vk_backspace](#vk_backspace), [vk_control](#vk_control), [vk_decimal](#vk_decimal), [vk_delete](#vk_delete), [vk_divide](#vk_divide), [vk_down](#vk_down), [vk_end](#vk_end), [vk_enter](#vk_enter), [vk_escape](#vk_escape), [vk_f1](#vk_f1), [vk_f10](#vk_f10), [vk_f11](#vk_f11), [vk_f12](#vk_f12), [vk_f2](#vk_f2), [vk_f3](#vk_f3), [vk_f4](#vk_f4), [vk_f5](#vk_f5), [vk_f6](#vk_f6), [vk_f7](#vk_f7), [vk_f8](#vk_f8), [vk_f9](#vk_f9), [vk_home](#vk_home), [vk_insert](#vk_insert), [vk_lalt](#vk_lalt), [vk_lcontrol](#vk_lcontrol), [vk_left](#vk_left), [vk_lshift](#vk_lshift), [vk_multiply](#vk_multiply), [vk_nokey](#vk_nokey), [vk_numpad0](#vk_numpad0), [vk_numpad1](#vk_numpad1), [vk_numpad2](#vk_numpad2), [vk_numpad3](#vk_numpad3), [vk_numpad4](#vk_numpad4), [vk_numpad5](#vk_numpad5), [vk_numpad6](#vk_numpad6), [vk_numpad7](#vk_numpad7), [vk_numpad8](#vk_numpad8), [vk_numpad9](#vk_numpad9), [vk_pagedown](#vk_pagedown), [vk_pageup](#vk_pageup), [vk_pause](#vk_pause), [vk_printscreen](#vk_printscreen), [vk_ralt](#vk_ralt), [vk_rcontrol](#vk_rcontrol), [vk_return](#vk_return), [vk_right](#vk_right), [vk_rshift](#vk_rshift), [vk_shift](#vk_shift), [vk_space](#vk_space), [vk_subtract](#vk_subtract), [vk_tab](#vk_tab), [vk_up](#vk_up), [webgl_enabled](#webgl_enabled), [while](#while), [working_directory](#working_directory)

## Operator Documentation

### add
Add two or more numbers (use 'cat' or 'string' to combine strings)
	- args: [A, B]
	- output: A + B (+ ...)
- constraints:
    - count(args) geq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### alias
Create an operator alias. Behavior depends on the number of arguments:

	0. Return the interpreter's entire alias struct
	1. If the argument names an operator or alias, return a list of all synonyms starting with the real name.
	2. Creates a new alias with nickname arg0 for operator arg1.  arg0 cannot be in use, arg1 must be defined.
	
	- args: [(nickname), (name)]
	- output: struct or list
- constraints:
    - count(args) leq 2
    - typeof(args[0]) in [ "string" ] (optional)
    - typeof(args[1]) in [ "string" ] (optional)

### and
Logical and operator
	    - args: [A, B]
	    - output: A and B

### angle
Find the shortest distance between two angles.
	- args: [end_angle, start_angle]
	- output: angle_difference
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)

### application_surface
[dynamic constant]

### approach
Increment a number by some amount while staying within a range
	- args: [number, increment, min, max]
	- output: [number]
- constraints:
    - count(args) eq 4
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### arctan2
Return arctan2 of an angle y/x. y = opposite side of triangle and x = adjacent side of triangle
	- args: [y, x]
	- output: arctan2(y, x)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)

### array
Create, read, or modify an array. Behavior depends on the number of arguments:

	0. Return an empty array
	1. Return [arg0]
	2. Return arg0[arg1]
	3. Set arg0[arg1] = arg2;
	- args: [(array), (index), (value)]
	- output: [*]
- aliases: [ "a" ]

### asset
Return the index of the named asset
	- args: [asset_name]
	- output: index
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### asset_type
Return the type of a variable
	- args: [*]
	- output: type_name
- constraints:
    - typeof(args[0]) in [ "ref","string" ] (required)

### async_load
[dynamic constant]

### cat
Concatenate arguments into a single string
	    - args: [value, (...)]
	    - output: [string]

### choose
Return a random element from a list.
	- args: [(max=1)]
	- output: number
- constraints:
    - typeof(args[0]) in [ "array" ] (required)

### clear
If run from a console, clear that console's history
	- args: []
	- output: instance
- constraints:
    - count(args) eq 0

### color
Create a color by name or hex code
	- args: [string]
	- output: color
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### color_inv
Return the RGB inverse of a color
	- args: [color]
	- output: color

### color_inv_hue
Return the hue inverse of a color, with the same saturation and value
	- args: [color]
	- output: color

### color_merge
Merge two colors by some amount
	- args: [color1, color2, fraction]
	- output: color3
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (required)

### color_rand
Create a random color
	- args: []
	- output: color

### console
Return a reference to the RunGML console, creating one if it doesn't exist
	- args: []
	- output: instance
- constraints:
    - count(args) leq 2
    - typeof(args[0]) in [ "string" ] (optional)

### cos
Return the cosine of an angle in raidans.
	- args: [angle]
	- output: cos/dcos/arccos/darccos(angle)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "bool" ] (optional)
    - typeof(args[2]) in [ "bool" ] (optional)

### create
Create a new object instance
	- args: [x, y, depth/layer_name, object_name]
	- output: [instance_id]
- constraints:
    - count(args) eq 4
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[3]) in [ "string","number","int32","int64" ] (required)

### current
Return the current time. Argument is a string specifying a date component: second/minute/hour/day/weekday/month/year, or s/m/h/d/w/M/y.  With no arguments, return the current datetime.
	- args: [('s'/'m'/'h'/'d'/'w'/'M'/'y')]
	- output: number
- constraints:
    - typeof(args[0]) in [ "string" ] (optional)

### current_day
[dynamic constant]

### current_hour
[dynamic constant]

### current_minute
[dynamic constant]

### current_month
[dynamic constant]

### current_second
[dynamic constant]

### current_time
[dynamic constant]

### current_year
[dynamic constant]

### cursor
Return the cursor's coordinates
	- args: []
	- output: [mouse_x, mouse_y]

### cursor_sprite
[dynamic constant]

### date_get
Get the second, minute, hour, day, weekday, month, or year from a datetime value.
	- args: [datetime, 's'/'m'/'h'/'d'/'w'/'M'/'y']
	- output: number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "string" ] (required)

### datestring
Create a string from a datetime value, or return the current datetime if no arguments are passed.
	- args: [(datetime)]
	- output: date_string
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)

### datetime
Create a datetime value
	- args: [year, month, day, hour, minute, second]
	- output: datetime
- constraints:
    - count(args) eq 6
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### debug
Enable or disable the GameMaker deubg overlay. Passing zero arguments toggles its visibility.
	    - args: [(enable), (minimize), (scale), (alpha)]
	    - output: []

### dec
Decrement a variable by some amount.  If the variable is undefined, set it to that amount.
	- args: [register_name, number]
	- output: []
- constraints:
    - typeof(args[0]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### delta
Return the time elapsed since the previous frame in seconds
	- args: []
	- output: number

### delta_time
[dynamic constant]

### destroy
Destroy an instance
	- args: [instance_id]
	- output: []

### display_gui_h
Returns the height of the display GUI.
	- args: []
	- output: [height]

### display_gui_w
Returns the width of the display GUI.
	- args: []
	- output: [width]

### display_h
Returns the height of the display.
	- args: []
	- output: [height]

### display_w
Returns the width of the display.
	- args: []
	- output: [width]

### div
Divide two numbers
	- args: [A, B]
	- output: A / B
- aliases: [ "divide" ]
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### do
Execute a function with an optional list of arguments in its original context using method_call().
	- args: [function, ([args])]
	- output: *
- constraints:
    - typeof(args[0]) in [ "method" ] (required)
    - typeof(args[1]) in [ "array" ] (optional)

### do_here
Execute a function with an optional list of arguments in the operator's context using script_execute_ext().  In most cases, use 'do' instead.
	- args: [function, ([args])]
	- output: *
- constraints:
    - typeof(args[0]) in [ "method" ] (required)
    - typeof(args[1]) in [ "array" ] (optional)

### dot
Find the dot product of two 2d vectors
	- args: [x1, y1, x2, y2]
	- output: dot_product
- constraints:
    - count(args) eq 4
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### dot3
Find the dot product of two 3d vectors
	- args: [x1, y1, z1, x2, y2, z2]
	- output: dot_product
- constraints:
    - count(args) eq 6
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### dot3_norm
Find the normalised dot product of two 3d vectors
	- args: [x1, y1, z1, x2, y2, z2]
	- output: dot_product
- constraints:
    - count(args) eq 6
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### dot_norm
Find the normalised dot product of two 2d vectors
	- args: [x1, y1, x2, y2]
	- output: dot_product
- constraints:
    - count(args) eq 4
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### draw_alpha
Get or set the draw alpha.
	- args: [(alpha)]
	- output: (alpha)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)

### draw_circle
Draw a circle
	- args: [x, y, (r=1), (outline=false), (c_center=draw_color), (c_edge=draw_color)]
	- output: []
- constraints:
    - count(args) in [ 3,4,5,6 ]
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (optional)
    - typeof(args[3]) in [ "bool" ] (optional)
    - typeof(args[4]) in [ "bool" ] (optional)

### draw_color
Get or set the draw color.
	- args: [(color)]
	- output: (color)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)

### draw_ellipse
Draw an ellipse
	- args: [x1, y1, x2, y2, (outline=false), (c_center=draw_color), (c_edge=draw_color)]
	- output: []
- constraints:
    - count(args) in [ 3,4,5,6 ]
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (required)
    - typeof(args[3]) in [ "number","int32","int64" ] (required)
    - typeof(args[4]) in [ "bool" ] (optional)
    - typeof(args[5]) in [ "number","int32","int64" ] (optional)
    - typeof(args[6]) in [ "number","int32","int64" ] (optional)

### draw_font
Get or set the draw font.
	- args: [(font name or asset reference)]
	- output: (font asset reference)
- constraints:
    - typeof(args[0]) in [ "string","ref" ] (required)

### draw_format
Get or set the draw font, horizontal alignment, vertical alignment, color, and alpha simultaneously.  Use to backup/restore settings before/after drawing to isolate changes.
	- args: [([font, h_align, v_align, color, alpha])]
	- output: ([font, h_align, v_align, color, alpha])
- constraints:
    - count(args) leq 1

### draw_halign
Get or set the horizontal draw alignment
	- args: [(value)]
	- output: (value)

### draw_line
Draw a line
	- args: [x1, y1, x2, y2, (color), (color2)]
	- output: []
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (required)
    - typeof(args[3]) in [ "number","int32","int64" ] (required)
    - typeof(args[4]) in [ "number","int32","int64" ] (optional)
    - typeof(args[5]) in [ "number","int32","int64" ] (optional)

### draw_point
Draw a point
	- args: [x, y, (color)]
	- output: []
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (optional)

### draw_rect
Draw a rectangle
	- args: [x1, y1, x2, y2, (outline=false), (c1=draw_color), (c2=c1, c3=c1, c4=c1)]
	- output: []
- constraints:
    - count(args) in [ 4,5,6,9 ]
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (required)
    - typeof(args[3]) in [ "number","int32","int64" ] (required)
    - typeof(args[4]) in [ "bool" ] (optional)
    - typeof(args[5]) in [ "number","int32","int64" ] (optional)
    - typeof(args[6]) in [ "number","int32","int64" ] (optional)
    - typeof(args[7]) in [ "number","int32","int64" ] (optional)
    - typeof(args[8]) in [ "number","int32","int64" ] (optional)

### draw_self
Draw text
	- args: [instance]
	- output: []
- constraints:
    - typeof(args[0]) in [ "ref" ] (required)

### draw_valign
Get or set the vertical draw alignment
	- args: [(value)]
	- output: (value)

### eq
Check whether two arguments are equivalent
	    - args: [A, B]
	    - output: [(A == B)]

### event_data
[dynamic constant]

### event_number
[dynamic constant]

### event_type
[dynamic constant]

### example
Run an included example program
	- args: [example_program_name]
	- output: *
- constraints:
    - typeof(args[0]) in [ "string" ] (required)
    - typeof(args[1]) in [ "bool" ] (optional)

### exec
Execute a string as a program.
	- args: [string]
	- output: *
- constraints:
    - count(args) eq 1
    - typeof(args[0]) in [ "string" ] (required)

### export
Export JSON to a file
	- args: [path, data, (pretty=true)]
	- output: []
- constraints:
    - typeof(args[0]) in [ "string" ] (required)
    - typeof(args[1]) in [ "array","struct" ] (required)
    - typeof(args[2]) in [ "bool" ] (optional)

### for
Exectue a RunGML program in a for loop.  Comparison should be one of the following strings: 'eq', 'neq', 'gt', 'lt', 'geq', 'leq'
	        for (var i=[start]; i [comparison] [reference]; i += increment) {run(program)}
		
	- args: [start, comparison, reference, increment, {'do': program}]
	- output: []
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "string" ] (required)
    - typeof(args[2]) in [ "number","int32","int64" ] (required)
    - typeof(args[3]) in [ "number","int32","int64" ] (required)
    - typeof(args[4]) in [ "struct" ] (required)

### fps
Get the current fps (capped at the room speed)
	- args: []
	- output: fps

### fps_real
Get the current fps (not capped at the room speed)
	- args: []
	- output: fps_real

### fullscreen
Toggle fullscreen mode.  Set status with a single boolean argument, or swap status with no arguments.
	- args: [(bool)]
	- output: []

### game_display_name
[dynamic constant]

### game_project_name
[dynamic constant]

### game_save_id
[dynamic constant]

### game_speed
Get or set the game speed in terms of fps
	- args: [(game_speed)]
	- output: (game_speed)

### game_time
Return the time in seconds since the game began
	- args: []
	- output: number

### geq
Check whether the first argument is greater than or equal to the second
	    - args: [A, B]
	    - output: [(A >= B)]

### global
Create, read, or modify global variables. Behavior depends on the number of arguments:

	0. Return an empty struct
	1. Return {'struct': arg0}
	2. Return get_struct(arg0, arg1)
	- args: []
	- output: []
- aliases: [ "g" ]

### gt
Check whether the first argument is greater than the second
	    - args: [A, B]
	    - output: [(A > B)]

### help
Display documentation for RunGML, or for an operator named by the first argument.
	- args: [(op_name)]
	- output: doc_string
- constraints:
    - count(args) leq 1
    - typeof(args[0]) in [ "string" ] (optional)

### hsv
Create an HSV color
	- args: [hue, saturation, value]
	- output: color

### if
Evaluate and act on a conditional
	- args: [conditional, {'true': program, 'false': program}]
	- output: []
- constraints:
    - typeof(args[0]) in [ "bool" ] (required)
    - typeof(args[1]) in [ "struct" ] (required)

### import
Import JSON from a file
	- args: [filepath]
	- output: json
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### in
Retrieve the output list from a struct produced by the 'out' operator.
	- args: [struct]
	- output: list
- constraints:
    - typeof(args[0]) in [ "struct" ] (required)

### inc
Increment a variable by some amount.  If the variable is undefined, set it to that amount.
	- args: [register_name, number]
	- output: []
- constraints:
    - typeof(args[0]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### inst
Get and set instance variables. Behavior depends on the number of arguments:

	2. Return variable_instance_get(arg0, arg1)
	3. Do variable_instance_set(arg0, arg1, arg2)
	- args: [instance, index, (value)]
	- output: *
- aliases: [ "i" ]

### instance_count
[dynamic constant]

### iter
Get the current loop iterator
	- args: []
	- output: []
- constraints:
    - count(args) eq 0

### iters
Get a list of all loop iterators
	- args: []
	- output: []
- constraints:
    - count(args) eq 0

### last
Return the value of the last argument
	- args: [*]
	- output: *

### len
Returns the length of a string, array, or struct.
	- args: [string/array/struct]
	- output: length

### lendir_x
Find the x component for a given vector
	- args: [length, direction]
	- output: x_component
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)

### lendir_y
Find the y component for a given vector
	- args: [length, direction]
	- output: y_component
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)

### leq
Check whether the first argument is less than or equal to the second
	    - args: [A, B]
	    - output: [(A <= B)]

### list
Return arguments as a list
	- args: []
	- output: []
- aliases: [ "l" ]

### log
Compute a logarithm.  Behavior depends on the number of arguments:

	0. Return the log of the argument in base 10
	1. Return the log of arg0 in the base of arg1
	- args: [number, (base=10)]
	- output: log_base(number)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### lt
Check whether the first argument is less than the second
	    - args: [A, B]
	    - output: [(A < B)]

### manual
Generate full markdown-formatted documentation for all RunGML operators and view it in the browser.
	- args: [(filename='RunGML/manual.md')]
	- output: []
- constraints:
    - count(args) eq 0

### map_range
Map a value proportionally from one range to another
	- args: [number, in_min, in_max, out_min, out_max]
	- output: number
- constraints:
    - count(args) eq 5
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### mod
Modulo operator
	- args: [A, B]
	- output: A mod B
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### mouse_button
[dynamic constant]

### mouse_lastbutton
[dynamic constant]

### mouse_x
[dynamic constant]

### mouse_y
[dynamic constant]

### mult
Multiply two numbers
	- args: [A, B]
	- output: A * B
- aliases: [ "multiply" ]
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### near
Return index of instance (arg2) nearest to some coordinates (arg0, arg1).
	- args: [(x=mouse_x), (y=mouse_y), (obj=any)]
	- output: index
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

### near_cursor
Return index of instance nearest to the mouse.  Optional argument specifies an object index or asset name.
	- args: [(object_index/asset_name)]
	- output: index
- constraints:
    - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

### neq
Check whether two arguments are not equal (inverse of 'eq')
	    - args: [A, B]
	    - output: [(A != B)]

### not
Return the inverse of the argument's boolean value
	    - args: [A]
	    - output: [!A]

### nth
Get the ordinal suffix for a given number
	- args: [number]
	- output: 'st', 'nd', 'rd', or 'th'

### object
Create a new oRunGML_Object instance and return its index
	- args: [x, y, depth/layer_name, event_dictionary]
	- output: oRunGML_Object instance
- aliases: [ "o" ]
- constraints:
    - count(args) eq 4
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "number","int32","int64" ] (required)
    - typeof(args[2]) in [ "string","number","int32","int64" ] (required)
    - typeof(args[3]) in [ "struct" ] (required)

### op_count
Return the number of supported operators
	- args: []
	- output: number
- constraints:
    - count(args) eq 0

### op_list
Return a list of supported operators
	- args: []
	- output: [string, *]
- constraints:
    - count(args) eq 0

### op_names
Return a string listing names of supported operators
	- args: []
	- output: string
- constraints:
    - count(args) eq 0

### op_search
Return a list of operators whose names contain a give string.
	- args: [string]
	- output: [string, *]
- constraints:
    - count(args) eq 1

### or
Logical or operator
	    - args: [A, B]
	    - output: [(A or B)]

### os_browser
[dynamic constant]

### os_device
[dynamic constant]

### os_type
[dynamic constant]

### os_version
[dynamic constant]

### out
Wrap argument list in a struct so it can be returned unevaluated.
	- args: [*]
	- output: struct

### parent
Return a reference to the RunGML interpreter's parent object.
	- args: []
	- output: instance
- aliases: [ "p" ]
- constraints:
    - count(args) leq 2

### pass
Do nothing
	- args: [*]
	- output: []

### point_dir
Find the direction from one point to another
	- args: [x1, y1, x2, y2]
	- output: distance
- constraints:
    - count(args) eq 4
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### point_dist
Find the distance between two points
	- args: [x1, y1, x2, y2]
	- output: distance
- constraints:
    - count(args) eq 4
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### pow
Raise one number to the power of another
	- args: [A, B]
	- output: A ^ B
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### print
Print a debug message
	    - args: [stringable, (...)]
	    - output: []

### prog
Run arguments as programs
	- args: []
	- output: []
- constraints:
    - typeof(args[0]) in [ "array" ] (required)

### program_directory
[dynamic constant]

### quit
Quit the game
	- args: []
	- output: []
- aliases: [ "q" ]

### rand
Return a random value.  Behavior depends on the number of arguments:
	0. Return a value between 0 and 1 (inclusive)
	1. Return a value between 0 and arg0 (inclusive)
	2. Return a value between arg0 and arg1 (inclusive)
	- args: [(max=1)]
	- output: number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### rand_int
Return a random integer.  Behavior depends on the number of arguments:
	0. Return either 0 or 1
	1. Return an integer between 0 and arg0 (inclusive)
	2. Return an integer between arg0 and arg1 (inclusive)
	- args: [(max=1)]
	- output: number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)
    - typeof(args[1]) in [ "number","int32","int64" ] (optional)

### rand_seed
Return a random value between 0 and some upper limit (defaults to 1).  Inclusive on both ends.
	- args: [(max=1)]
	- output: number
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (optional)

### rec_cancel
If run from a console, cancel recording input lines.
	- args: []
	- output: []

### rec_delete
Delete one or more lines from the recorded program.
	- args: [start_line, (line_count=1)]
	- output: [preview]

### rec_pause
If run from a console, pause recording input lines.  Resume recording later with rec_pause.
	- args: []
	- output: []

### rec_preview
Preview the program currently stored as a recording, if one exists.  Accepts an optional argument which prints pretty JSON if true.
	- args: [(pretty)]
	- output: [preview]

### rec_replay
Run a program recorded via the console with rec_start/rec_stop
	- args: [program_name, (clean)]
	- output: *
- constraints:
    - typeof(args[0]) in [ "string" ] (required)
    - typeof(args[1]) in [ "bool" ] (optional)

### rec_resume
If run from a console, resume recording input lines, after pausing with rec_pause.
	- args: []
	- output: []

### rec_start
If run from a console, start recording the following lines to be saved as a program whenever [rec_stop, program_name] is entered.
	- args: [(program_type)]
	- output: []
- constraints:
    - typeof(args[0]) in [ "string" ] (optional)

### rec_stop
If run from a console, stop recording and save recorded lines as a program.
	- args: [program_name]
	- output: []
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### reference
Operate on referenced values.  Behavior depends on the number of arguments:

	0. Return the interpreter's registers struct (same as ['v'])
	1. (or more) If the first argument names an operator:
	    - Substitute any other arguments that name defined reigsters with their values.
	    - Run the first-argument operator on the resulting list of substituted arguments.
	    - For example, the following two programs are functionally equivalent:
	        - ['r', 'add', 'foo', 'bar']
	        - ['add', ['v', 'foo'], ['v', 'bar']]
	    - They will return the sum of the values in registers 'foo' and 'bar'.
	- args: [(operator), (register_name, ...)]
	- output: *
- aliases: [ "r" ]

### reference_parent
Similar to the 'reference' ('r') operator, but substitutes with values from the parent's instance variables.  Behavior depends on the number of arguments:

	0. Return the names of all parent instance variables
	1. (or more) If the first argument names an operator:
	    - Substitute any other arguments that name parent instance variables with their values
	    - Run the first-argument operator on the resulting list of substituted arguments.
	    - For example, the following two programs are functionally equivalent:
	        - ['rp', 'add', 'foo', 'bar']
	        - ['add', ['p', 'foo'], ['p', 'bar']]
	    - They will return the sum of the values in parent instance variables 'foo' and 'bar'.
	- args: [(operator), (variable, ...)]
	- output: *
- aliases: [ "rp" ]

### repeat
Repeat a RunGML program a fixed number of times
	- args: [count, {'do': program}]
	- output: []
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "struct" ] (required)

### restart
Restart the game
	- args: []
	- output: []

### rgb
Create an RGB color
	- args: [red, green, blue]
	- output: color

### rickroll
Got 'em!
	- args: []
	- output: []

### room
Behavior depends on the number of arguments:

	0. Return the name of the current room
	1. Go to the named room, if it exists
	    - args: [(room_name)]
	    - output: [(room_name)]

### room_first
[dynamic constant]

### room_h
Returns the height of the current room.
	    - args: []
	    - output: [height]

### room_last
[dynamic constant]

### room_next
Go to the next room.
	    - args: []
	    - output: [height]

### room_w
Returns the width of the current room.
	    - args: []
	    - output: [width]

### run
Run arguments as a program, with the first argument becoming the new operator.
	- args: [*]
	- output: *

### run_clean
Run arguments as a program, with the first argument becoming the new operator. Creates and uses a separate interpreter instance.
	- args: [*]
	- output: *

### runfile
Run a program from a file
	- args: [filepath]
	- output: *
- constraints:
    - typeof(args[0]) in [ "string" ] (required)
    - typeof(args[1]) in [ "bool" ] (optional)

### runprog
Run a program from a file in the incdlued RunGML/programs directory.
	- args: [program_name, (clean)]
	- output: *
- constraints:
    - typeof(args[0]) in [ "string" ] (required)
    - typeof(args[1]) in [ "bool" ] (optional)

### screenshot
Save a screenshot to RunGML/screenshots/timestamp.png.  Or pass a filename in place of generating a timestamp.
	- args: [(filename)]
	- output: []

### shader
Get or set the current shader. Zero arguments to get, one to set.
	- args: [(shader)]
	- output: [(shader)]
- constraints:
    - typeof(args[0]) in [ "string","number","int32","int64" ] (optional)

### shader_reset
Clear shaders
	- args: []
	- output: []

### sin
Return the sine of an angle in raidans.
	- args: [angle]
	- output: sin/dsin/arcsin/darcsin(angle)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "bool" ] (optional)
    - typeof(args[2]) in [ "bool" ] (optional)

### sprite
Create a new sprite from a file
	- args: [sprite_index, frame, x, y]
	- output: []

### string
Format a string
	    - args: [template, (var0), ...]
	    - output: [string]
- aliases: [ "str" ]
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### struct
Create, read, or modify a struct. Behavior depends on the number of arguments:

	0. Return an empty struct
	1. Return {'struct': arg0}
	2. Return get_struct(arg0, arg1)
	3. Return set_struct(arg0, arg1, arg2);
	- args: []
	- output: []
- aliases: [ "s" ]

### struct_keys
Get a list of the keys in a struct
	- args: [struct]
	- output: [string, ...]

### sub
Subtract two numbers
	- args: [A, B]
	- output: A - B
- aliases: [ "subtract" ]
- constraints:
    - count(args) eq 2
    - typeof(args[all]) in [ "number","int32","int64" ] (required)

### switch
Perform switch/case evaluation
	- args: [value, {'case0': program, 'case1': program, 'default': program}]
	- output: []
- constraints:
    - count(args) eq 2
    - typeof(args[1]) in [ "struct" ] (required)

### tan
Return the tangent of an angle in raidans.
	- args: [angle, (degrees=true), (inverse=false)]
	- output: tan/dtan/arctan/darctan(angle)
- constraints:
    - typeof(args[0]) in [ "number","int32","int64" ] (required)
    - typeof(args[1]) in [ "bool" ] (optional)
    - typeof(args[2]) in [ "bool" ] (optional)

### temp_directory
[dynamic constant]

### test_operator
Test operator
- args: []
- output: string
- aliases: [ "test_alias","test_alias_alias" ]
- constraints:
    - count(args) geq 0

### this
Return a reference to the current RunGML interpreter
	- args: []
	- output: instance
- aliases: [ "t" ]
- constraints:
    - count(args) eq 0

### type
Return the type of a variable
	- args: [*]
	- output: type_name
- constraints:
    - count(args) eq 1

### undefined
Return the GameMaker constant undefined, or determines whether the optional argument is undefined.
	- args: [(variable)]
	- output: undefined or True/False
- constraints:
    - count(args) leq 1

### update
Open the RunGML homepage in the browser
	- args: []
	- output: string
- constraints:
    - count(args) eq 0

### url_open
Open a URL in the default browser
	- args: [URL]
	- output: []
- constraints:
    - typeof(args[0]) in [ "string" ] (required)

### var
Get and set variables.  Behavior changes based on number of arguments:

	0. Return the interpreter's entire registers struct.
	1. Return the value saved in the named register.
	2. Set the register named by the first argument to the value of the second argument.
	- args: [int] or [string]
	- output: *
- aliases: [ "v" ]

### view_current
[dynamic constant]

### webgl_enabled
[dynamic constant]

### while
Exectue a RunGML program while a condition is true
	- args: [{'check': program, 'do': program}]
	- output: []
- constraints:
    - typeof(args[0]) in [ "struct" ] (required)

### working_directory
[dynamic constant]


## Constants

#### all
-3
#### animcurvetype_catmullrom
1
#### animcurvetype_linear
0
#### asset_animationcurve
10
#### asset_font
6
#### asset_object
0
#### asset_path
4
#### asset_room
3
#### asset_script
5
#### asset_sequence
9
#### asset_shader
8
#### asset_sound
2
#### asset_sprite
1
#### asset_tiles
13
#### asset_timeline
7
#### asset_unknown
-1
#### audio_3d
2
#### audio_falloff_exponent_distance
5
#### audio_falloff_exponent_distance_clamped
6
#### audio_falloff_exponent_distance_scaled
8
#### audio_falloff_inverse_distance
1
#### audio_falloff_inverse_distance_clamped
2
#### audio_falloff_linear_distance
3
#### audio_falloff_linear_distance_clamped
4
#### audio_falloff_none
0
#### audio_mono
0
#### audio_stereo
1
#### bboxkind_diamond
3
#### bboxkind_ellipse
2
#### bboxkind_precise
0
#### bboxkind_rectangular
1
#### bboxmode_automatic
0
#### bboxmode_fullimage
1
#### bboxmode_manual
2
#### bm_add
1
#### bm_dest_alpha
7
#### bm_dest_color
9
#### bm_dest_colour
9
#### bm_inv_dest_alpha
8
#### bm_inv_dest_color
10
#### bm_inv_src_alpha
6
#### bm_inv_src_color
4
#### bm_inv_src_colour
4
#### bm_max
2
#### bm_normal
0
#### bm_one
2
#### bm_src_alpha
5
#### bm_src_alpha_sat
11
#### bm_src_color
3
#### bm_src_colour
3
#### bm_subtract
3
#### bm_zero
1
#### browser_chrome
3
#### browser_edge
11
#### browser_firefox
2
#### browser_ie
1
#### browser_ie_mobile
10
#### browser_not_a_browser
-1
#### browser_opera
6
#### browser_safari
4
#### browser_safari_mobile
5
#### browser_unknown
0
#### browser_windows_store
8
#### buffer_bool
10
#### buffer_f16
7
#### buffer_f32
8
#### buffer_f64
9
#### buffer_fast
3
#### buffer_fixed
0
#### buffer_grow
1
#### buffer_s16
4
#### buffer_s32
6
#### buffer_s8
2
#### buffer_seek_end
2
#### buffer_seek_relative
1
#### buffer_seek_start
0
#### buffer_string
11
#### buffer_text
13
#### buffer_u16
3
#### buffer_u32
5
#### buffer_u64
12
#### buffer_u8
1
#### buffer_vbuffer
4
#### buffer_wrap
2
#### c_aqua
16776960
#### c_black
0
#### c_blue
16711680
#### c_dkgray
4210752
#### c_fuchsia
16711935
#### c_gray
8421504
#### c_green
32768
#### c_lime
65280
#### c_ltgray
12632256
#### c_maroon
128
#### c_navy
8388608
#### c_olive
32896
#### c_orange
4235519
#### c_purple
8388736
#### c_red
255
#### c_silver
12632256
#### c_teal
8421376
#### c_white
16777215
#### c_yellow
65535
#### cmpfunc_always
8
#### cmpfunc_equal
3
#### cmpfunc_greater
5
#### cmpfunc_greaterequal
7
#### cmpfunc_less
2
#### cmpfunc_lessequal
4
#### cmpfunc_never
1
#### cmpfunc_notequal
6
#### cr_appstart
-19
#### cr_arrow
-2
#### cr_beam
-4
#### cr_cross
-3
#### cr_default
0
#### cr_drag
-12
#### cr_handpoint
-21
#### cr_hourglass
-11
#### cr_none
-1
#### cr_size_all
-22
#### cr_size_nesw
-6
#### cr_size_ns
-7
#### cr_size_nwse
-8
#### cr_size_we
-9
#### cr_uparrow
-10
#### cull_clockwise
1
#### cull_counterclockwise
2
#### cull_noculling
0
#### device_emulator
256
#### device_ios_ipad
2
#### device_ios_ipad_retina
3
#### device_ios_iphone
0
#### device_ios_iphone5
4
#### device_ios_iphone6
5
#### device_ios_iphone6plus
6
#### device_ios_iphone_retina
1
#### device_ios_unknown
-1
#### device_tablet
2
#### display_landscape
0
#### display_landscape_flipped
2
#### display_portrait
1
#### display_portrait_flipped
3
#### dll_cdecl
0
#### dll_stdcall
1
#### ds_type_grid
5
#### ds_type_list
2
#### ds_type_map
1
#### ds_type_priority
6
#### ds_type_queue
4
#### ds_type_stack
3
#### e
2.71828183
#### ef_cloud
9
#### ef_ellipse
2
#### ef_explosion
0
#### ef_firework
3
#### ef_flare
8
#### ef_rain
10
#### ef_ring
1
#### ef_smoke
4
#### ef_smokeup
5
#### ef_snow
11
#### ef_spark
7
#### ef_star
6
#### ev_alarm
2
#### ev_animation_end
7
#### ev_async_audio_playback
74
#### ev_async_audio_recording
73
#### ev_async_dialog
63
#### ev_async_push_notification
71
#### ev_async_save_load
72
#### ev_async_social
70
#### ev_async_system_event
75
#### ev_async_web
62
#### ev_async_web_cloud
67
#### ev_async_web_iap
66
#### ev_async_web_image_load
60
#### ev_async_web_networking
68
#### ev_async_web_steam
69
#### ev_boundary
1
#### ev_boundary_view0
50
#### ev_boundary_view1
51
#### ev_boundary_view2
52
#### ev_boundary_view3
53
#### ev_boundary_view4
54
#### ev_boundary_view5
55
#### ev_boundary_view6
56
#### ev_boundary_view7
57
#### ev_broadcast_message
76
#### ev_cleanup
12
#### ev_collision
4
#### ev_create
0
#### ev_destroy
1
#### ev_draw
8
#### ev_draw_begin
72
#### ev_draw_end
73
#### ev_draw_post
77
#### ev_draw_pre
76
#### ev_end_of_path
8
#### ev_game_end
3
#### ev_game_start
2
#### ev_gesture
13
#### ev_gesture_double_tap
1
#### ev_gesture_drag_end
4
#### ev_gesture_drag_start
2
#### ev_gesture_dragging
3
#### ev_gesture_flick
5
#### ev_gesture_pinch_end
9
#### ev_gesture_pinch_in
7
#### ev_gesture_pinch_out
8
#### ev_gesture_pinch_start
6
#### ev_gesture_rotate_end
12
#### ev_gesture_rotate_start
10
#### ev_gesture_rotating
11
#### ev_gesture_tap
0
#### ev_global_gesture_double_tap
65
#### ev_global_gesture_drag_end
68
#### ev_global_gesture_drag_start
66
#### ev_global_gesture_dragging
67
#### ev_global_gesture_flick
69
#### ev_global_gesture_pinch_end
73
#### ev_global_gesture_pinch_in
71
#### ev_global_gesture_pinch_out
72
#### ev_global_gesture_pinch_start
70
#### ev_global_gesture_rotate_end
76
#### ev_global_gesture_rotate_start
74
#### ev_global_gesture_rotating
75
#### ev_global_gesture_tap
64
#### ev_global_left_button
50
#### ev_global_left_press
53
#### ev_global_left_release
56
#### ev_global_middle_button
52
#### ev_global_middle_press
55
#### ev_global_middle_release
58
#### ev_global_right_button
51
#### ev_global_right_press
54
#### ev_global_right_release
57
#### ev_gui
64
#### ev_gui_begin
74
#### ev_gui_end
75
#### ev_keyboard
5
#### ev_keypress
9
#### ev_keyrelease
10
#### ev_left_button
0
#### ev_left_press
4
#### ev_left_release
7
#### ev_middle_button
2
#### ev_middle_press
6
#### ev_middle_release
9
#### ev_mouse
6
#### ev_mouse_enter
10
#### ev_mouse_leave
11
#### ev_mouse_wheel_down
61
#### ev_mouse_wheel_up
60
#### ev_no_button
3
#### ev_no_more_health
9
#### ev_no_more_lives
6
#### ev_other
7
#### ev_outside
0
#### ev_outside_view0
40
#### ev_outside_view1
41
#### ev_outside_view2
42
#### ev_outside_view3
43
#### ev_outside_view4
44
#### ev_outside_view5
45
#### ev_outside_view6
46
#### ev_outside_view7
47
#### ev_pre_create
14
#### ev_right_button
1
#### ev_right_press
5
#### ev_right_release
8
#### ev_room_end
5
#### ev_room_start
4
#### ev_step
3
#### ev_step_begin
1
#### ev_step_end
2
#### ev_step_normal
0
#### ev_user0
10
#### ev_user1
11
#### ev_user10
20
#### ev_user11
21
#### ev_user12
22
#### ev_user13
23
#### ev_user14
24
#### ev_user15
25
#### ev_user2
12
#### ev_user3
13
#### ev_user4
14
#### ev_user5
15
#### ev_user6
16
#### ev_user7
17
#### ev_user8
18
#### ev_user9
19
#### fa_archive
32
#### fa_bottom
2
#### fa_center
1
#### fa_directory
16
#### fa_hidden
2
#### fa_left
0
#### fa_middle
1
#### fa_readonly
1
#### fa_right
2
#### fa_sysfile
4
#### fa_top
0
#### fa_volumeid
8
#### false
0
#### gamespeed_fps
0
#### gamespeed_microseconds
1
#### gm_build_date
46150.61784564
#### gm_build_type
run
#### gm_runtime_version
2024.14.4.268
#### gm_version
1.2.0.0
#### gp_axis_acceleration_x
32789
#### gp_axis_acceleration_y
32790
#### gp_axis_acceleration_z
32791
#### gp_axis_angular_velocity_x
32792
#### gp_axis_angular_velocity_y
32793
#### gp_axis_angular_velocity_z
32794
#### gp_axis_orientation_w
32798
#### gp_axis_orientation_x
32795
#### gp_axis_orientation_y
32796
#### gp_axis_orientation_z
32797
#### gp_axislh
32785
#### gp_axislv
32786
#### gp_axisrh
32787
#### gp_axisrv
32788
#### gp_face1
32769
#### gp_face2
32770
#### gp_face3
32771
#### gp_face4
32772
#### gp_padd
32782
#### gp_padl
32783
#### gp_padr
32784
#### gp_padu
32781
#### gp_select
32777
#### gp_shoulderl
32773
#### gp_shoulderlb
32775
#### gp_shoulderr
32774
#### gp_shoulderrb
32776
#### gp_start
32778
#### gp_stickl
32779
#### gp_stickr
32780
#### infinity
inf
#### kbv_autocapitalize_characters
3
#### kbv_autocapitalize_none
0
#### kbv_autocapitalize_sentences
2
#### kbv_autocapitalize_words
1
#### kbv_returnkey_continue
10
#### kbv_returnkey_default
0
#### kbv_returnkey_done
9
#### kbv_returnkey_emergency
11
#### kbv_returnkey_go
1
#### kbv_returnkey_google
2
#### kbv_returnkey_join
3
#### kbv_returnkey_next
4
#### kbv_returnkey_route
5
#### kbv_returnkey_search
6
#### kbv_returnkey_send
7
#### kbv_returnkey_yahoo
8
#### kbv_type_ascii
1
#### kbv_type_default
0
#### kbv_type_email
3
#### kbv_type_numbers
4
#### kbv_type_phone
5
#### kbv_type_phone_name
6
#### kbv_type_url
2
#### layerelementtype_background
1
#### layerelementtype_instance
2
#### layerelementtype_oldtilemap
3
#### layerelementtype_particlesystem
6
#### layerelementtype_sequence
8
#### layerelementtype_sprite
4
#### layerelementtype_tile
7
#### layerelementtype_tilemap
5
#### layerelementtype_undefined
0
#### lighttype_dir
0
#### lighttype_point
1
#### matrix_projection
1
#### matrix_view
0
#### matrix_world
2
#### mb_any
-1
#### mb_left
1
#### mb_middle
3
#### mb_none
0
#### mb_right
2
#### mb_side1
4
#### mb_side2
5
#### mip_markedonly
2
#### mip_off
0
#### mip_on
1
#### nan
NaN
#### network_config_avoid_time_wait
4
#### network_config_connect_timeout
0
#### network_config_disable_reliable_udp
3
#### network_config_enable_reliable_udp
2
#### network_config_use_non_blocking_socket
1
#### network_config_websocket_protocol
5
#### network_connect_blocking
1
#### network_connect_nonblocking
2
#### network_connect_none
0
#### network_send_binary
1
#### network_send_text
2
#### network_socket_bluetooth
2
#### network_socket_tcp
0
#### network_socket_udp
1
#### network_socket_ws
6
#### network_type_connect
1
#### network_type_data
3
#### network_type_disconnect
2
#### network_type_down
7
#### network_type_non_blocking_connect
4
#### network_type_up
5
#### network_type_up_failed
6
#### nineslice_blank
3
#### nineslice_bottom
3
#### nineslice_center
4
#### nineslice_centre
4
#### nineslice_hide
4
#### nineslice_left
0
#### nineslice_mirror
2
#### nineslice_repeat
1
#### nineslice_right
2
#### nineslice_stretch
0
#### nineslice_top
1
#### noone
-4
#### os_android
4
#### os_gdk
23
#### os_gxgames
24
#### os_ios
3
#### os_linux
6
#### os_macosx
1
#### os_operagx
24
#### os_permission_denied
0
#### os_permission_denied_dont_request
-1
#### os_permission_granted
1
#### os_ps4
14
#### os_ps5
22
#### os_switch
21
#### os_tvos
20
#### os_unknown
-1
#### os_windows
0
#### os_xboxseriesxs
23
#### path_action_continue
2
#### path_action_restart
1
#### path_action_reverse
3
#### path_action_stop
0
#### phi
1.61803399
#### phy_debug_render_aabb
8
#### phy_debug_render_collision_pairs
64
#### phy_debug_render_coms
4
#### phy_debug_render_core_shapes
32
#### phy_debug_render_joints
2
#### phy_debug_render_obb
16
#### phy_debug_render_shapes
1
#### phy_joint_anchor_1_x
0
#### phy_joint_anchor_1_y
1
#### phy_joint_anchor_2_x
2
#### phy_joint_anchor_2_y
3
#### phy_joint_angle
8
#### phy_joint_angle_limits
21
#### phy_joint_damping_ratio
17
#### phy_joint_frequency
18
#### phy_joint_length_1
15
#### phy_joint_length_2
16
#### phy_joint_lower_angle_limit
19
#### phy_joint_max_force
24
#### phy_joint_max_length
22
#### phy_joint_max_motor_force
14
#### phy_joint_max_motor_torque
10
#### phy_joint_max_torque
23
#### phy_joint_motor_force
13
#### phy_joint_motor_speed
7
#### phy_joint_motor_torque
9
#### phy_joint_reaction_force_x
4
#### phy_joint_reaction_force_y
5
#### phy_joint_reaction_torque
6
#### phy_joint_speed
12
#### phy_joint_translation
11
#### phy_joint_upper_angle_limit
20
#### phy_particle_data_flag_category
16
#### phy_particle_data_flag_color
8
#### phy_particle_data_flag_colour
8
#### phy_particle_data_flag_position
2
#### phy_particle_data_flag_typeflags
1
#### phy_particle_data_flag_velocity
4
#### phy_particle_flag_colormixing
256
#### phy_particle_flag_colourmixing
256
#### phy_particle_flag_elastic
16
#### phy_particle_flag_powder
64
#### phy_particle_flag_spring
8
#### phy_particle_flag_tensile
128
#### phy_particle_flag_viscous
32
#### phy_particle_flag_wall
4
#### phy_particle_flag_water
0
#### phy_particle_flag_zombie
2
#### phy_particle_group_flag_rigid
2
#### phy_particle_group_flag_solid
1
#### pi
3.14159265
#### pointer_invalid
FFFFFFFFFFFFFFFF
#### pointer_null
null
#### pr_linelist
2
#### pr_linestrip
3
#### pr_pointlist
1
#### pr_trianglefan
6
#### pr_trianglelist
4
#### pr_trianglestrip
5
#### ps_distr_gaussian
1
#### ps_distr_invgaussian
2
#### ps_distr_linear
0
#### ps_shape_diamond
2
#### ps_shape_ellipse
1
#### ps_shape_line
3
#### ps_shape_rectangle
0
#### pt_shape_circle
5
#### pt_shape_cloud
11
#### pt_shape_disk
1
#### pt_shape_explosion
10
#### pt_shape_flare
8
#### pt_shape_line
3
#### pt_shape_pixel
0
#### pt_shape_ring
6
#### pt_shape_smoke
12
#### pt_shape_snow
13
#### pt_shape_spark
9
#### pt_shape_sphere
7
#### pt_shape_square
2
#### pt_shape_star
4
#### seqaudiokey_loop
0
#### seqaudiokey_oneshot
1
#### seqdir_left
-1
#### seqdir_right
1
#### seqinterpolation_assign
0
#### seqinterpolation_lerp
1
#### seqplay_loop
1
#### seqplay_oneshot
0
#### seqplay_pingpong
2
#### seqtracktype_audio
2
#### seqtracktype_bool
5
#### seqtracktype_clipmask
8
#### seqtracktype_clipmask_mask
9
#### seqtracktype_clipmask_subject
10
#### seqtracktype_color
4
#### seqtracktype_colour
4
#### seqtracktype_empty
12
#### seqtracktype_graphic
1
#### seqtracktype_group
11
#### seqtracktype_instance
14
#### seqtracktype_message
15
#### seqtracktype_moment
16
#### seqtracktype_real
3
#### seqtracktype_sequence
7
#### seqtracktype_spriteframes
13
#### seqtracktype_string
6
#### spritespeed_framespergameframe
1
#### spritespeed_framespersecond
0
#### tau
6.28318531
#### test_constant
42
#### tf_anisotropic
2
#### tf_linear
1
#### tf_point
0
#### tile_flip
536870912
#### tile_index_mask
524287
#### tile_mirror
268435456
#### tile_rotate
1073741824
#### time_source_expire_after
1
#### time_source_expire_nearest
0
#### time_source_game
1
#### time_source_global
0
#### time_source_state_active
1
#### time_source_state_initial
0
#### time_source_state_paused
2
#### time_source_state_stopped
3
#### time_source_units_frames
1
#### time_source_units_seconds
0
#### timezone_local
0
#### timezone_utc
1
#### tm_countvsyncs
1
#### tm_sleep
0
#### true
1
#### ty_real
0
#### ty_string
1
#### version
1.3.0
#### vertex_type_color
5
#### vertex_type_colour
5
#### vertex_type_float1
1
#### vertex_type_float2
2
#### vertex_type_float3
3
#### vertex_type_float4
4
#### vertex_type_ubyte4
6
#### vertex_usage_binormal
9
#### vertex_usage_blendindices
6
#### vertex_usage_blendweight
5
#### vertex_usage_color
2
#### vertex_usage_colour
2
#### vertex_usage_depth
13
#### vertex_usage_fog
12
#### vertex_usage_normal
3
#### vertex_usage_position
1
#### vertex_usage_psize
7
#### vertex_usage_sample
14
#### vertex_usage_tangent
8
#### vertex_usage_texcoord
4
#### vertex_usage_textcoord
4
#### video_format_rgba
0
#### video_format_yuv
1
#### video_status_closed
0
#### video_status_paused
3
#### video_status_playing
2
#### video_status_preparing
1
#### vk_add
107
#### vk_alt
18
#### vk_anykey
1
#### vk_backspace
8
#### vk_control
17
#### vk_decimal
110
#### vk_delete
46
#### vk_divide
111
#### vk_down
40
#### vk_end
35
#### vk_enter
13
#### vk_escape
27
#### vk_f1
112
#### vk_f10
121
#### vk_f11
122
#### vk_f12
123
#### vk_f2
113
#### vk_f3
114
#### vk_f4
115
#### vk_f5
116
#### vk_f6
117
#### vk_f7
118
#### vk_f8
119
#### vk_f9
120
#### vk_home
36
#### vk_insert
45
#### vk_lalt
164
#### vk_lcontrol
162
#### vk_left
37
#### vk_lshift
160
#### vk_multiply
106
#### vk_nokey
0
#### vk_numpad0
96
#### vk_numpad1
97
#### vk_numpad2
98
#### vk_numpad3
99
#### vk_numpad4
100
#### vk_numpad5
101
#### vk_numpad6
102
#### vk_numpad7
103
#### vk_numpad8
104
#### vk_numpad9
105
#### vk_pagedown
34
#### vk_pageup
33
#### vk_pause
19
#### vk_printscreen
44
#### vk_ralt
165
#### vk_rcontrol
163
#### vk_return
13
#### vk_right
39
#### vk_rshift
161
#### vk_shift
16
#### vk_space
32
#### vk_subtract
109
#### vk_tab
9
#### vk_up
38