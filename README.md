# ElektraTest
Test con conexion a themoviedb

Ejercicio Técnico (App de Películas/Series)
<ul>
<li>Películas y/o series categorizadas por Playing Now y Most Popular <span style="color: green">&#10003;</span></li>
<li>Detalle de película y/o serie <span style="color: green">&#10003;</span></li>
<li>Visualización de videos en el detalle <span style="color: green">&#10003;</span></li>
<li>La app debe de funcionar offline <span style="color: green">&#10003;</span></li>
<li>
Opcional:
<ul>
<li>Pruebas unitarias<span style="color: green">&#10003;</span>
</li>
<li>Documentación de código.</li>
<li>Agregar un buscador</li>
</ul>
</li>
</ul>

<ul>
<li>API: https://developers.themoviedb.org/ <span style="color: green">&#10003;</span></li>
<li>Usar Swift <span style="color: green">&#10003;</span></li>
<li>Subir el proyecto a Github/Bitbucket/Gitlab o cualquier otro que utilice Git <span style="color: green">&#10003;</span></li>
<li>La App debe ser escalable, con lo cual toda buena práctica que conozca aplíquela <span style="color: green">&#10003;</span></li>
<li>Usar algún patrón de arquitectura: ej. MVVM <span style="color: green">&#10003;</span>, MVP, Viper...</li>
<li>Detalla cómo harías todo aquello que no hayas llegado a completar en el README.md del
proyecto<span style="color: green">&#10003;</span></li>
<li>El soporte debe ser a partir de iOS 11<span style="color: green">&#10003;</span></li>
</ul>

Adicionales incluidos en el proyecto:
<ul>
<li>Soporte múltiples orientaciones</li>
<li>Soporte lenguaje inglés y español</li>
<li>Páginación</li>
<li>Assets provisionales para: splash screen, íconos para botones, icono para aplicación</li>
</ul>

Consideraciones
<ul>
<li>Actualmente se asume que los videos se mostrarán en YouTube, en la implementación de las pruebas unitarias
se observó que VIMEO también aparece como <code>site</code> en el arreglo de videos, así que el soporte de múltiples 
plataformas sería adecuado. Debido a que, la documentación no clarifica las posibles fuentes de video, se considera
que se requiere observar más detalles de series/peliculas para determinar otras posibles fuentes.</li>
<li>Actualmente pocas series ofrecen videos en español, una de las que sí tienen es la serie The Good Doctor, si se requieren más pruebas con los videos, se sugiere probar con la aplicación en idioma inglés</li>
</ul>

Opcionales que me gustaría implementar
<ul>
<li>Agregar un buscador, usando el endpoint: <code>https://api.themoviedb.org/3/search/multi?api_
key=<<api_key>>&language=en-US&page=1&include_adult=false</code> y mostrando los resultados en una pantalla
adicional</li>
<li>Mejorar la interfaz de usuario, ej.
<ul>
<li>Mejorar la paleta de colores</li>
<li>Añadir más animaciones</li>
<li>Interfaz específica para iPad</li>
<li>Mostrar más información, ej. genero, compañias asociadas, páginas de streamings, etc.</li>
</ul>
</li>
</ul>
