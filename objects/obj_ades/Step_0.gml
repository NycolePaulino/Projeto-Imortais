/// @description Lógica principal de movimentação e estados

// Iniciando variáveis de controle
var right, left, jump, attack;
var chao = place_meeting(x, y + 1, obj_block); // Verifica se está no chão

right = keyboard_check(ord("D")); // Tecla para mover à direita
left = keyboard_check(ord("A"));  // Tecla para mover à esquerda
jump = keyboard_check_pressed(ord("W")); // Pulo com tecla pressionada (evita pulo contínuo)
attack = keyboard_check_pressed(ord("J"));

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
        sprite_index = spr_ades_parado;

        // Mudança de estado
        if (right || left) {
            estado = "movendo";
        } else if (jump || velv != 0) {
            estado = "pulando";
            velv = (-max_velv * jump); // Impulso inicial para o pulo
			image_index = 0;
        } else if (attack) {
			estado = "ataque";
			velh = 0;
		}
        break;
    }

    case "movendo": {
        // Comportamento do estado de movimento
        sprite_index = spr_ades_run;

        // Mudança de estado
        if (abs(velh) < 0.1) {
            estado = "parado";
            velh = 0;
        } else if (jump) {
            estado = "pulando";
			image_index = 0;
            velv = -max_velv;
        } else if(attack) {
			estado = "ataque";
			velh = 0;
			image_index = 0;
		}
        break;
    }

    case "pulando": {
        // Comportamento durante o pulo
        if (velv > 0) {
            sprite_index = spr_ades_parado; // Troca sprite quando está caindo
        } else {
            sprite_index = spr_ades_parado; // Sprite durante o pulo
            if (image_index >= image_number - 1) {
                image_index = image_number - 1; // Garante que a animação não se repita
            }
        }

        // Mudança de estado
        if (chao) {
            estado = "parado";
            // Ajusta o personagem para fora do bloco, caso necessário
            while (place_meeting(x, y + 1, obj_block)) {
                y -= 1;
            }
        }
        break;
    }
	
	case "ataque": {
		velh = 0;
		
		if(combo == 0) {
			sprite_index = spr_ades_attack1;
		} else if(combo == 1) {
			sprite_index = spr_ades_attack2;
		} else if(combo == 2) {
			sprite_index = spr_ades_attack1;
		}
		
	
		
		if(attack && combo < 2 && image_index >= image_number-2) {
			combo++;
			image_index = 0;
		}
		
		
		if(image_index > image_number-1){
			estado = "parado";
			velh = 0;
			combo = 0;
		}
		
		break;
	}
}
