import styles from '../../app/css/Home.module.css';
import ComponenteBusca from './componente_busca';

export default async function ObraPage() {
  const res = await fetch("http://localhost:3000/api/obras");
  const obras = await res.json();
  
  return (
   <div className="px-50">

    <h1 className="text-4xl font-bold text-center font-serif mt-6 mb-10">Obras</h1>

    <ComponenteBusca obras={ obras }/>

   </div>
  );
}
