//import { verificacionUsuario } from '../../controlador/loginControlador.js'
$(function () {
    $("#btnIngresar").click(function () {
        //Evita refrescar pagina
        event.preventDefault();
        var usuario = $('#username').val();
        var contrasenia = $('#password').val();
        usuario = String(usuario);
        contrasenia = String(contrasenia);
        console.log(usuario + '-' + contrasenia)
        if (usuario.length != 0 && contrasenia.length != 0) {
            $.ajax({
                url: '/verificarUsuario',
                method: 'post',
                data: {
                    id: usuario,
                    password: contrasenia
                },
                success: function (response) {
                    console.log(response.estado)
                    if (response.estado != 0) {
                        var pageName = "principal.html";
                        document.location.href = pageName;
                    } else {
                        $("#username").val('');
                        $("#password").val('');
                        alert('Usuario o Contraseña Incorrecta ')
                    }
                },
                error: function () {
                    alert('Error al verificar usuario')
                }
            });
        } else {
            alert('Ingrese usuario y contraseña');
        }
    });

})


