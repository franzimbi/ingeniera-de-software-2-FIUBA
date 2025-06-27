para empezar hice una copia de app_inversor con el nombre de alquiler y
la pushee a una rama 'alquiler'. por alguna razon falla en el gitlab, pero lo voy a arreglar
en el proximo commit.

Ahora estoy usando el esqueleto de inversor para crear mi clase rental que, por ahora, tiene 
un solo metodo calculate donde se reciben los parametros y devolvera el importe y gastos. Tambien 
comente todos los tests de inversor y trato de hacaer pasar un solo test de rental.

Al pasar el primer test creado para la logica de la clase Rspec se queja de que tengo baja cobertura 
en tests, asi que ademas de hacer pasar un test de logica agregue un test de api en app_wep_spec para 
que tenga cobertura  > 75%.

Ahora los tests me pasan localmente pero en gitlab me fallan.

Solucione el tema del pipeline. asi que comienzo a mejorar la app y agregar test iterativamente.
refactorice la clase rental, y ahora hace bien el calculo por horas.

Agrego test de cuit empresarial por horas y corre corectamente. lo commiteo a gitlab.

agregue logica para alquiler por dia con sus respectivos tests. lo commiteo a gitlab.

agregue test de web con un alquiler por dia para empresa. tambien cambien el get alquilar a alquiler, 
para respetar el enunciado.

agregue tests par alquiler por km tanto para cuit normal como empresarial. lo commiteo.

Comiento a refactorizar el metodo calculate para que quede mas lindo. modularizo en metodos privados de 
la clase rental.

agrego test para cuando el tipo de alquiler es invalido. separe en metodos el calculo del total y 
el descuento para cuit empresarial. commiteo.

agregue tests para cuando el dato o el cuit no es un integrer. commiteo.

probe en terminal y en mi web client la consulta del enunciado y funciona bien. pusheo y entrego el tp

