/// @description Lógica principal de movimentação e estados

// Iniciando variáveis de controle
var right, left, jump, attack;
var chao = place_meeting(x, y + 1, obj_block); // Verifica se está no chão

right = keyboard_check(ord("D")); // Tecla para mover à direita
left = keyboard_check(ord("A"));  // Tecla para mover à esquerda
jump = keyboard_check_pressed(ord("W")); // Pulo com tecla pressionada (evita pulo contínuo)
ataque = keyboard_check_pressed(ord("J"));

// Movimento horizontal
velh = (right - left) * max_velh;

// Aplicando gravidade
if (!chao) {
    if (velv < max_velv) { // Limita a velocidade vertical
        velv += GRAVIDADE * massa; // Aumenta a velocidade vertical
    }
} else {
    velv = 0; // Zera a velocidade vertical ao tocar no chão
}

// Máquina de estados
switch (estado) {
    case "parado": {
        // Comportamento do estado parado
        sprite_index = spr_medusa_parado;

        // Mudança de estado
        if (right || left) {
            estado = "movendo";
        } else if (jump) {
            estado = "pulando";
            velv = -max_velv; // Impulso inicial para o pulo
        } else if (ataque) {
			estado = "parado";
			velh = 0;
		}
        break;
    }

    case "movendo": {
        // Comportamento do estado de movimento
        sprite_index = spr_medusa_run;

        // Mudança de estado
        if (abs(velh) < 0.1) {
            estado = "parado";
            velh = 0;
        } else if (jump) {
            estado = "pulando";
            velv = -max_velv;
        } else if(ataque) {
			estado = "ataque";
			velh = 0;
		}
        break;
    }

}
