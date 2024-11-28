/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// olhando para o lado certo 
if(velh != 0) xscale = sign(velh);
image_xscale = xscale;

//exibindo meu estado quando o usuário mandar 
if(position_meeting(mouse_x, mouse_y, id)) {
	if(mouse_check_button_released(mb_left))
	mostra_estado = !mostra_estado;
	
}