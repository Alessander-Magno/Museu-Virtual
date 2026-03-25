import styles from '../../app/css/Home.module.css';
import ComponenteBusca from './componente_busca';

export default async function AtracaoPage() {
  const res = await fetch("http://localhost:3000/api/atracoes");
  const atracoes = await res.json();

  return (
   <div className="px-50">

    <h1 className="text-4xl font-bold text-center font-serif mt-6 mb-10">Atrações</h1>

    <ComponenteBusca atracoes={ atracoes }/>

   </div>
  );
}
