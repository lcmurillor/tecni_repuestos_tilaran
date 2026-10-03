# Tecni Repuestos Tilarán — prototipo web

Adaptación del proyecto móvil Flutter para mostrarlo en un portafolio. Conserva las pantallas y la identidad visual originales en una vista centrada de hasta 480 px.

## Ejecutar

Comprobado con Flutter **3.47.4** y Dart **3.13.3** en Windows.

```powershell
flutter pub get
flutter run -d chrome
```

También se puede usar `flutter run -d web-server --web-port 8080` y abrir la dirección que indique Flutter.

## Compilar y publicar

```powershell
flutter build web --release --no-web-resources-cdn
```

La salida está en `build/web`. Publicar **todo el contenido** de esa carpeta en un alojamiento estático con HTTPS. No necesita un servidor de aplicación ni credenciales. No abrir `index.html` directamente mediante `file://`; usar un servidor HTTP.

Para alojarlo en una subcarpeta del portafolio, por ejemplo `/tecni-repuestos/`:

```powershell
flutter build web --release --no-web-resources-cdn --base-href /tecni-repuestos/
```

El prefijo debe empezar y terminar con `/`. Se conserva la navegación con hash de Flutter. No se ha publicado el prototipo en un servicio externo.

Para probar localmente el build (si Python está instalado):

```powershell
python -m http.server 8080 --bind 127.0.0.1 --directory build/web
```

Abrir `http://127.0.0.1:8080`.

## Qué se puede explorar

- Catálogo de 12 productos ficticios, categorías de repuestos y accesorios.
- Búsqueda por descripción, código o categoría, sin distinguir mayúsculas.
- Ficha del producto al pulsar su nombre, disponibilidad y precios de ejemplo.
- Carrito: agregar, cambiar cantidades, quitar productos y calcular totales.
- Simular un pedido y consultar su estado; incluye un pedido de ejemplo.
- Perfil ficticio, direcciones locales, pantalla informativa de acceso y sección Acerca de.

El visitante entra directamente, sin cuenta. Hay un aviso permanente de prototipo. El inicio de sesión, registro, recuperación/cambio de contraseña, cargas de archivos y contactos están deshabilitados. La compra simulada no solicita depósitos, comprobantes ni pagos reales.

Los cambios viven **solo en memoria de la pestaña** y se restablecen al recargar. No se comparten entre visitantes. La preferencia de tema puede guardarse localmente mediante SharedPreferences. Los 12 productos tienen imágenes ilustrativas de Wikimedia Commons incluidas en `assets/products/`; los créditos y licencias están en **Acerca de → Créditos de imágenes**, `assets/products/credits.json` y `docs/IMAGE_CREDITS.md`; la fuente Roboto y su licencia se incluyen en `assets/fonts`, sin descargar fuentes de Google. Los datos comerciales y textos de la pantalla Acerca de son parte del diseño histórico, no una confirmación de información vigente.

## Datos y Firebase

- `lib/Services/demo_seed.dart`: catálogo, categorías, perfil, dirección y pedido ficticios incluidos en el build. Editar este archivo para cambiar el contenido.
- `lib/Services/demo_database.dart`: almacenamiento en memoria y consultas/listas locales reactivas, limitadas a las operaciones que utiliza esta aplicación.
- `lib/Services/local_data_service.dart`: adaptación de las operaciones del servicio original a memoria.
- `lib/Services/demo_auth_service.dart`: identidad fija de visitante, sin autenticación.
- `lib/Services/demo_storage_service.dart`: aviso de cargas deshabilitadas.
- `lib/Services/firebase_*.dart`: implementaciones originales **conservadas comentadas**, sin importarse ni ejecutarse.
- `docs/firebase-web-original.html.txt`: arranque web original conservado como referencia fuera de los archivos publicables.

Las dependencias Firebase y Google Sign-In quedaron comentadas en `pubspec.yaml`. El arranque de Firebase en `main.dart` está desactivado y `web/index.html` utiliza el bootstrap actual de Flutter. Recuperar el backend requiere un proyecto Firebase nuevo, configuración, reglas y volver a conectar los servicios; no basta con descomentar una línea.

También se sustituyeron paquetes antiguos de iconos y badges por componentes del SDK, se corrigieron rutas de imports con mayúsculas/minúsculas y se adaptó el tema a Flutter actual. Esta entrega se valida para web; no se ha validado la compilación Android/iOS.

## Verificación

```powershell
flutter test
flutter analyze --no-fatal-infos
flutter build web --release --no-web-resources-cdn
```

Las pruebas cubren consultas del catálogo, búsquedas vacías, carrito, serialización de pedidos y navegación desde el catálogo hasta un pedido simulado y su detalle a 390 px de ancho. El código heredado conserva sugerencias del analizador sobre estilo y APIs obsoletas; no impiden compilar.
