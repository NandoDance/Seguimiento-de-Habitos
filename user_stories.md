# Historias de Usuario - Habit Tracker

---

## Historia 1: Página de Inicio de Sesión

**Title:**
_Como usuario registrado, quiero iniciar sesión con mi nombre de usuario y contraseña, para poder acceder a mi cuenta y a mis hábitos guardados._

**Acceptance Criteria:**
1. El usuario puede ingresar su nombre de usuario y contraseña en campos de formulario.
2. Al presionar el botón de inicio de sesión con credenciales válidas, el usuario es redirigido a la página de inicio.
3. Si las credenciales son incorrectas, se muestra un mensaje de error claro al usuario.
4. Existe un enlace visible para navegar a la página de registro.

**Priority:** High
**Story Points:** 3
**Notes:**
- Validar que los campos no estén vacíos antes de enviar.
- Considerar ocultar/mostrar la contraseña con un icono.

---

## Historia 2: Página de Registro

**Title:**
_Como nuevo usuario, quiero registrarme con mis datos personales, para poder crear una cuenta y comenzar a usar la aplicación._

**Acceptance Criteria:**
1. El usuario puede ingresar nombre, correo electrónico, nombre de usuario y contraseña.
2. Se valida que el correo tenga formato válido y que la contraseña cumpla requisitos mínimos.
3. Si el nombre de usuario ya existe, se muestra un mensaje de error.
4. Al registrarse exitosamente, el usuario es redirigido a la página de inicio de sesión o de inicio.

**Priority:** High
**Story Points:** 3
**Notes:**
- Los datos del registro se guardan localmente para persistencia.
- Incluir opción de seleccionar país desde una lista.

---

## Historia 3: Página de Inicio (Home)

**Title:**
_Como usuario autenticado, quiero ver un mensaje de bienvenida y un resumen de mi progreso, para tener una visión general de mis hábitos al entrar a la aplicación._

**Acceptance Criteria:**
1. Se muestra un mensaje/cita de bienvenida personalizada con el nombre del usuario.
2. Se muestra la lista de hábitos actuales del usuario.
3. Se muestra el progreso general (hábitos completados vs. pendientes).
4. Existe un botón visible para agregar un nuevo hábito.

**Priority:** High
**Story Points:** 5
**Notes:**
- La página de inicio es la pantalla principal tras el inicio de sesión.

---

## Historia 4: Pantalla Detallada (Agregar/Gestionar Hábitos)

**Title:**
_Como usuario, quiero agregar, editar y eliminar hábitos con sus detalles, para poder gestionar y personalizar mis tareas diarias._

**Acceptance Criteria:**
1. El usuario puede crear un nuevo hábito con nombre, descripción y frecuencia.
2. El usuario puede editar o eliminar hábitos existentes.
3. El usuario puede marcar un hábito como completado desde la pantalla de detalle.
4. Los cambios se reflejan inmediatamente en la página de inicio.

**Priority:** High
**Story Points:** 5
**Notes:**
- Confirmar con un diálogo antes de eliminar un hábito.

---

## Historia 5: Menú de Navegación

**Title:**
_Como usuario, quiero acceder a un menú de navegación, para moverme fácilmente entre las diferentes secciones de la aplicación._

**Acceptance Criteria:**
1. El menú muestra opciones para: Inicio, Perfil/Información personal, Informes, Notificaciones y Configuración.
2. Al seleccionar una opción, el usuario es llevado a la pantalla correspondiente.
3. El menú es accesible desde las pantallas principales de la aplicación.
4. El menú incluye una opción para cerrar sesión.

**Priority:** Medium
**Story Points:** 3
**Notes:**
- Puede implementarse como Drawer o menú lateral.

---

## Historia 6: Pantalla de Configuración y Perfil

**Title:**
_Como usuario, quiero ver y editar mi información personal y ajustar la configuración de la aplicación, para personalizar mi experiencia según mis preferencias._

**Acceptance Criteria:**
1. El usuario puede ver su información de registro (nombre, correo, país, etc.).
2. El usuario puede editar y guardar cambios en su información personal.
3. El usuario puede cambiar configuraciones como tema (claro/oscuro).
4. Los cambios se guardan de forma persistente.

**Priority:** Medium
**Story Points:** 3
**Notes:**
- Mostrar mensaje de confirmación al guardar cambios exitosamente.

---

## Historia 7: Integración de Datos Persistentes

**Title:**
_Como usuario, quiero que mis datos (cuenta, hábitos y progreso) se guarden localmente, para no perder mi información al cerrar la aplicación._

**Acceptance Criteria:**
1. Los datos de registro e inicio de sesión persisten entre sesiones.
2. Los hábitos creados y su estado (completado/pendiente) se guardan localmente.
3. Al reabrir la aplicación, el usuario autenticado accede directamente sin volver a iniciar sesión.
4. La configuración personalizada (tema, notificaciones) se mantiene guardada.

**Priority:** High
**Story Points:** 5
**Notes:**
- Implementar con `shared_preferences` o almacenamiento local equivalente.

---

## Historia 8: Integración de API Externa

**Title:**
_Como usuario, quiero que la aplicación consuma datos de una API externa (por ejemplo, lista de países), para contar con información actualizada y dinámica en los formularios._

**Acceptance Criteria:**
1. La aplicación consume una API externa para obtener la lista de países en el registro.
2. Los datos de la API se muestran correctamente en un selector o lista desplegable.
3. Se maneja el estado de carga mientras se obtienen los datos.
4. Se muestra un mensaje de error amigable si la API no responde.

**Priority:** Medium
**Story Points:** 5
**Notes:**
- Considerar caché de respuestas para mejorar el rendimiento.
- Manejar el caso de falta de conexión a internet.

---

## Historia 9: Notificaciones y Recordatorios

**Title:**
_Como usuario, quiero configurar notificaciones y recordatorios de mis hábitos, para no olvidar completarlos durante el día._

**Acceptance Criteria:**
1. El usuario puede activar o desactivar las notificaciones desde la pantalla de notificaciones.
2. El usuario puede programar recordatorios con hora y frecuencia para cada hábito.
3. Las notificaciones locales se muestran a la hora programada aunque la app esté cerrada.
4. El usuario puede ver y administrar sus recordatorios existentes.

**Priority:** Medium
**Story Points:** 5
**Notes:**
- Implementar con `flutter_local_notifications`.
- Solicitar permisos de notificaciones en el primer uso.
