from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector

app = Flask(__name__)
app.secret_key = "bp2-secret-key"

DB_CONFIG = {
    "host": "localhost",
    "user": "appuser",
    "password": "App12345!",
    "database": "hnl_ocjenjivanje",
}

def get_conn():
    return mysql.connector.connect(**DB_CONFIG)

@app.route("/")
def home():
    return redirect(url_for("igraci_list"))

# -----------------------
# IGRACI CRUD
# -----------------------

@app.route("/igraci")
def igraci_list():
    conn = get_conn()
    cur = conn.cursor(dictionary=True)

    cur.execute("""
        SELECT i.igrac_id, i.ime, i.prezime, i.pozicija, i.broj_dresa,
               k.skraceni_naziv AS klub,
               d.naziv AS drzava
        FROM igrac i
        JOIN klub k ON k.klub_id = i.klub_id
        JOIN drzava d ON d.drzava_id = i.drzava_id
        ORDER BY k.skraceni_naziv, i.prezime, i.ime
    """)
    igraci = cur.fetchall()

    cur.close()
    conn.close()
    return render_template("igraci.html", igraci=igraci)

@app.route("/igraci/novi", methods=["GET", "POST"])
def igrac_novi():
    conn = get_conn()
    cur = conn.cursor(dictionary=True)

    cur.execute("SELECT klub_id, skraceni_naziv FROM klub ORDER BY skraceni_naziv")
    klubovi = cur.fetchall()
    cur.execute("SELECT drzava_id, naziv FROM drzava ORDER BY naziv")
    drzave = cur.fetchall()

    if request.method == "POST":
        ime = request.form["ime"].strip()
        prezime = request.form["prezime"].strip()
        datum_rodenja = request.form["datum_rodenja"]
        visina = request.form.get("visina") or None
        pozicija = request.form["pozicija"].strip()
        broj_dresa = request.form.get("broj_dresa") or None
        klub_id = request.form["klub_id"]
        drzava_id = request.form["drzava_id"]

        cur2 = conn.cursor()
        cur2.execute("""
            INSERT INTO igrac (ime, prezime, datum_rodenja, visina, pozicija, broj_dresa, klub_id, drzava_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (ime, prezime, datum_rodenja, visina, pozicija, broj_dresa, klub_id, drzava_id))
        conn.commit()
        cur2.close()

        flash("Igrač uspješno dodan.")
        cur.close()
        conn.close()
        return redirect(url_for("igraci_list"))

    cur.close()
    conn.close()
    return render_template("igrac_forma.html", mode="novi", igrac=None, klubovi=klubovi, drzave=drzave)

@app.route("/igraci/<int:igrac_id>/uredi", methods=["GET", "POST"])
def igrac_uredi(igrac_id):
    conn = get_conn()
    cur = conn.cursor(dictionary=True)

    cur.execute("SELECT * FROM igrac WHERE igrac_id = %s", (igrac_id,))
    igrac = cur.fetchone()
    if not igrac:
        cur.close()
        conn.close()
        flash("Igrač nije pronađen.")
        return redirect(url_for("igraci_list"))

    cur.execute("SELECT klub_id, skraceni_naziv FROM klub ORDER BY skraceni_naziv")
    klubovi = cur.fetchall()
    cur.execute("SELECT drzava_id, naziv FROM drzava ORDER BY naziv")
    drzave = cur.fetchall()

    if request.method == "POST":
        ime = request.form["ime"].strip()
        prezime = request.form["prezime"].strip()
        datum_rodenja = request.form["datum_rodenja"]
        visina = request.form.get("visina") or None
        pozicija = request.form["pozicija"].strip()
        broj_dresa = request.form.get("broj_dresa") or None
        klub_id = request.form["klub_id"]
        drzava_id = request.form["drzava_id"]

        cur2 = conn.cursor()
        cur2.execute("""
            UPDATE igrac
            SET ime=%s, prezime=%s, datum_rodenja=%s, visina=%s,
                pozicija=%s, broj_dresa=%s, klub_id=%s, drzava_id=%s
            WHERE igrac_id=%s
        """, (ime, prezime, datum_rodenja, visina, pozicija, broj_dresa, klub_id, drzava_id, igrac_id))
        conn.commit()
        cur2.close()

        flash("Igrač uspješno ažuriran.")
        cur.close()
        conn.close()
        return redirect(url_for("igraci_list"))

    cur.close()
    conn.close()
    return render_template("igrac_forma.html", mode="uredi", igrac=igrac, klubovi=klubovi, drzave=drzave)

@app.route("/igraci/<int:igrac_id>/obrisi", methods=["POST"])
def igrac_obrisi(igrac_id):
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM igrac WHERE igrac_id = %s", (igrac_id,))
        conn.commit()
        flash("Igrač obrisan.")
    except mysql.connector.Error as e:
        flash(f"Greška pri brisanju: {e.msg}")
    cur.close()
    conn.close()
    return redirect(url_for("igraci_list"))

# -----------------------
# STATISTIKA CRUD
# -----------------------

@app.route("/statistika")
def stat_list():
    conn = get_conn()
    cur = conn.cursor(dictionary=True)

    cur.execute("""
        SELECT
          si.statistika_id,
          u.utakmica_id,
          u.datum_vrijeme,
          k1.skraceni_naziv AS domaci,
          k2.skraceni_naziv AS gost,
          CONCAT(u.gol_domaci, ' : ', u.gol_gost) AS rezultat,
          CONCAT(i.ime, ' ', i.prezime) AS igrac,
          k.skraceni_naziv AS klub_igraca,
          si.minute, si.golovi, si.asistencije,
          si.udarci, si.udarci_u_okvir,
          si.dodavanja, si.uspjesna_dodavanja,
          si.kljucna_dodavanja,
          si.driblinzi, si.uspjesni_driblinzi,
          si.prekrsaji, si.zuti, si.crveni,
          o.vrijednost AS ocjena
        FROM statistika_igraca si
        JOIN igrac i ON i.igrac_id = si.igrac_id
        JOIN klub k ON k.klub_id = i.klub_id
        JOIN utakmica u ON u.utakmica_id = si.utakmica_id
        JOIN klub k1 ON k1.klub_id = u.domaci_klub_id
        JOIN klub k2 ON k2.klub_id = u.gostujuci_klub_id
        LEFT JOIN ocjena o ON o.statistika_id = si.statistika_id
        ORDER BY u.datum_vrijeme DESC, si.statistika_id DESC
    """)
    rows = cur.fetchall()

    cur.close()
    conn.close()
    return render_template("statistika.html", rows=rows)

@app.route("/statistika/nova", methods=["GET", "POST"])
def stat_nova():
    conn = get_conn()
    cur = conn.cursor(dictionary=True)

    cur.execute("""
        SELECT u.utakmica_id, u.datum_vrijeme,
               k1.skraceni_naziv AS domaci,
               k2.skraceni_naziv AS gost
        FROM utakmica u
        JOIN klub k1 ON k1.klub_id = u.domaci_klub_id
        JOIN klub k2 ON k2.klub_id = u.gostujuci_klub_id
        ORDER BY u.datum_vrijeme DESC
    """)
    utakmice = cur.fetchall()

    cur.execute("""
        SELECT i.igrac_id,
               CONCAT(i.ime,' ',i.prezime) AS igrac,
               k.skraceni_naziv AS klub
        FROM igrac i
        JOIN klub k ON k.klub_id = i.klub_id
        ORDER BY k.skraceni_naziv, i.prezime, i.ime
    """)
    igraci = cur.fetchall()

    if request.method == "POST":
        data = {
            "minute": int(request.form.get("minute") or 0),
            "golovi": int(request.form.get("golovi") or 0),
            "asistencije": int(request.form.get("asistencije") or 0),
            "udarci": int(request.form.get("udarci") or 0),
            "udarci_u_okvir": int(request.form.get("udarci_u_okvir") or 0),
            "dodavanja": int(request.form.get("dodavanja") or 0),
            "uspjesna_dodavanja": int(request.form.get("uspjesna_dodavanja") or 0),
            "kljucna_dodavanja": int(request.form.get("kljucna_dodavanja") or 0),
            "driblinzi": int(request.form.get("driblinzi") or 0),
            "uspjesni_driblinzi": int(request.form.get("uspjesni_driblinzi") or 0),
            "prekrsaji": int(request.form.get("prekrsaji") or 0),
            "zuti": int(request.form.get("zuti") or 0),
            "crveni": int(request.form.get("crveni") or 0),
            "igrac_id": int(request.form["igrac_id"]),
            "utakmica_id": int(request.form["utakmica_id"]),
        }

        try:
            cur2 = conn.cursor()
            cur2.execute("""
                INSERT INTO statistika_igraca
                (minute, golovi, asistencije, udarci, udarci_u_okvir,
                 dodavanja, uspjesna_dodavanja, kljucna_dodavanja,
                 driblinzi, uspjesni_driblinzi, prekrsaji, zuti, crveni,
                 igrac_id, utakmica_id)
                VALUES
                (%(minute)s, %(golovi)s, %(asistencije)s, %(udarci)s, %(udarci_u_okvir)s,
                 %(dodavanja)s, %(uspjesna_dodavanja)s, %(kljucna_dodavanja)s,
                 %(driblinzi)s, %(uspjesni_driblinzi)s, %(prekrsaji)s, %(zuti)s, %(crveni)s,
                 %(igrac_id)s, %(utakmica_id)s)
            """, data)
            conn.commit()
            cur2.close()
            flash("Statistika dodana. Ocjena se izračunala automatski (trigger).")
            cur.close()
            conn.close()
            return redirect(url_for("stat_list"))
        except mysql.connector.Error as e:
            flash(f"Greška: {e.msg}")

    cur.close()
    conn.close()
    return render_template("statistika_forma.html", mode="nova", row=None, utakmice=utakmice, igraci=igraci)

@app.route("/statistika/<int:statistika_id>/uredi", methods=["GET", "POST"])
def stat_uredi(statistika_id):
    conn = get_conn()
    cur = conn.cursor(dictionary=True)

    cur.execute("SELECT * FROM statistika_igraca WHERE statistika_id=%s", (statistika_id,))
    row = cur.fetchone()
    if not row:
        cur.close()
        conn.close()
        flash("Statistika nije pronađena.")
        return redirect(url_for("stat_list"))

    cur.execute("""
        SELECT u.utakmica_id, u.datum_vrijeme,
               k1.skraceni_naziv AS domaci,
               k2.skraceni_naziv AS gost
        FROM utakmica u
        JOIN klub k1 ON k1.klub_id = u.domaci_klub_id
        JOIN klub k2 ON k2.klub_id = u.gostujuci_klub_id
        ORDER BY u.datum_vrijeme DESC
    """)
    utakmice = cur.fetchall()

    cur.execute("""
        SELECT i.igrac_id,
               CONCAT(i.ime,' ',i.prezime) AS igrac,
               k.skraceni_naziv AS klub
        FROM igrac i
        JOIN klub k ON k.klub_id = i.klub_id
        ORDER BY k.skraceni_naziv, i.prezime, i.ime
    """)
    igraci = cur.fetchall()

    if request.method == "POST":
        data = {
            "minute": int(request.form.get("minute") or 0),
            "golovi": int(request.form.get("golovi") or 0),
            "asistencije": int(request.form.get("asistencije") or 0),
            "udarci": int(request.form.get("udarci") or 0),
            "udarci_u_okvir": int(request.form.get("udarci_u_okvir") or 0),
            "dodavanja": int(request.form.get("dodavanja") or 0),
            "uspjesna_dodavanja": int(request.form.get("uspjesna_dodavanja") or 0),
            "kljucna_dodavanja": int(request.form.get("kljucna_dodavanja") or 0),
            "driblinzi": int(request.form.get("driblinzi") or 0),
            "uspjesni_driblinzi": int(request.form.get("uspjesni_driblinzi") or 0),
            "prekrsaji": int(request.form.get("prekrsaji") or 0),
            "zuti": int(request.form.get("zuti") or 0),
            "crveni": int(request.form.get("crveni") or 0),
            "igrac_id": int(request.form["igrac_id"]),
            "utakmica_id": int(request.form["utakmica_id"]),
            "statistika_id": statistika_id,
        }

        try:
            cur2 = conn.cursor()
            cur2.execute("""
                UPDATE statistika_igraca
                SET minute=%(minute)s, golovi=%(golovi)s, asistencije=%(asistencije)s,
                    udarci=%(udarci)s, udarci_u_okvir=%(udarci_u_okvir)s,
                    dodavanja=%(dodavanja)s, uspjesna_dodavanja=%(uspjesna_dodavanja)s,
                    kljucna_dodavanja=%(kljucna_dodavanja)s,
                    driblinzi=%(driblinzi)s, uspjesni_driblinzi=%(uspjesni_driblinzi)s,
                    prekrsaji=%(prekrsaji)s, zuti=%(zuti)s, crveni=%(crveni)s,
                    igrac_id=%(igrac_id)s, utakmica_id=%(utakmica_id)s
                WHERE statistika_id=%(statistika_id)s
            """, data)
            conn.commit()
            cur2.close()
            flash("Statistika ažurirana. Ocjena je automatski ažurirana (trigger).")
            cur.close()
            conn.close()
            return redirect(url_for("stat_list"))
        except mysql.connector.Error as e:
            flash(f"Greška: {e.msg}")

    cur.close()
    conn.close()
    return render_template("statistika_forma.html", mode="uredi", row=row, utakmice=utakmice, igraci=igraci)

@app.route("/statistika/<int:statistika_id>/obrisi", methods=["POST"])
def stat_obrisi(statistika_id):
    conn = get_conn()
    cur = conn.cursor()
    try:
        cur.execute("DELETE FROM statistika_igraca WHERE statistika_id=%s", (statistika_id,))
        conn.commit()
        flash("Statistika obrisana.")
    except mysql.connector.Error as e:
        flash(f"Greška pri brisanju: {e.msg}")
    cur.close()
    conn.close()
    return redirect(url_for("stat_list"))

if __name__ == "__main__":
    app.run(debug=True)
