// Definição da Fonte
draw_set_font(ft_menu);

// Obter dimensões da GUI
var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();
var x1 = gui_width / 2;
var y1 = gui_height / 2 + 100;
var base_margin = 60; // Margem padrão entre opções
var extra_margin_after_jogar = 20; // Margem adicional após "Jogar"

// Obter posição do mouse na GUI
var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);

// Configurar alinhamento do texto
draw_set_halign(fa_center);
draw_set_valign(fa_center);

// Definir arrays de cores para cada opção
// Atualmente, todas as opções têm a mesma cor; você pode personalizar conforme necessário
var option_colors = [
    c_red,     
    c_ltgray,
    c_ltgray,     
    c_ltgray      
];

// Definir arrays de cores de hover para cada opção
// Atualmente, todas as opções têm a mesma cor de hover; você pode personalizar conforme necessário
var option_hover_colors = [
    #B22222,   
    #778899,  
    #778899,     
    #778899	      
];

// Definir cor da borda
var cor_borda = c_black;  // Cor padrão da borda

// Inicializar a posição vertical atual
var current_y = y1;

// Loop para desenhar cada opção do menu
for (var i = 0; i < op_max; i++) {
    var option_text = options[i];
    var string_w = string_width(option_text);
    var string_h = string_height(option_text);

    // Define uma escala padrão com base na opção
    var scale = (option_text == "Jogar") ? 1.3 : 0.8;

    // Definir a cor padrão do texto para esta opção
    var cor_texto_normal = option_colors[i];
    var cor_texto_hover = option_hover_colors[i];
    var cor_texto = cor_texto_normal;

    var y2 = current_y; // Posição vertical atual para desenhar a opção

    // Verifica se o mouse está sobre o botão e ajusta a escala e cor
    if (point_in_rectangle(m_x, m_y, 
        x1 - (string_w / 2 * scale), 
        y2 - (string_h / 2 * scale), 
        x1 + (string_w / 2 * scale), 
        y2 + (string_h / 2 * scale))) {
        
        cor_texto = option_hover_colors[i]; // Usa a cor de hover correta
        scale += 0.2; // Aumenta a escala quando o mouse está sobre
        var index = i;

        // Detecta clique do mouse
        if (mouse_check_button_pressed(mb_left)) {
            switch (index) {
                case 0:
                    room_goto(rm_fase1);
                    break;
                case 1:
                    room_goto(rm_historia);
                    break;
                case 2:
                    room_goto(rm_configuracoes);
                    break;
                case 3:
                    game_end();
                    break;
            }
        }
    }

    // Desenhar a borda ao redor do texto com uma borda mais grossa (deslocamento maior)
    draw_set_color(cor_borda);  // Define a cor da borda como preta
    for (var x_off = -2; x_off <= 2; x_off++) {
        for (var y_off = -2; y_off <= 2; y_off++) {
            // Desenhar a borda ao redor com deslocamento de até 2 pixels em todas as direções
            if (x_off != 0 || y_off != 0) {  // Evita sobrepor o texto central
                draw_text_transformed(x1 + x_off, y2 + y_off, option_text, scale, scale, 0);
            }
        }
    }

    // Desenha o texto principal por cima
    draw_set_color(cor_texto);  // Define a cor do texto (hover ou normal)
    draw_text_transformed(x1, y2, option_text, scale, scale, 0);  // Desenha o texto principal com a escala

    // Incrementa a posição vertical para a próxima opção
    current_y += base_margin;

    // Se a opção atual for "Jogar", adiciona uma margem extra após ela
    if (option_text == "Jogar") {
        current_y += extra_margin_after_jogar;
    }
}
