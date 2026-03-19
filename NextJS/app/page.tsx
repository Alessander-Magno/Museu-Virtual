import Image from "next/image";
import Link from 'next/link';
import styles from './css/Home.module.css';

export default function Home() {
  return (
    <main className={styles.container}>
      <h1 className={styles.title}>Museu Virtual</h1>
      
      <nav className={styles.navigation} aria-label="Navegação principal">
        <Link href="/atracoes" className={styles.navLink}>
          <span className={styles.navButton} role="button" tabIndex={0}>
            🎭 Atrações
          </span>
        </Link>

        <Link href="/obras" className={styles.navLink}>
          <span className={styles.navButton} role="button" tabIndex={0}>
            🖼️ Obras
          </span>
        </Link>
      </nav>
    </main>
    );
}
