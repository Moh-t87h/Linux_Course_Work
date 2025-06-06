
## 🌱 BioData Linux Final Project – Tel-Hai Academic College

This project was developed as the final assignment for the Linux (WSL) course, part of the BioData track in Biotechnology studies at **Tel-Hai Academic College**.

###🧰 Project Overview

The goal of this project was to integrate Linux-based scripting with real-world bioinformatics and DevOps principles. The work includes tasks such as repository setup, data organization, scripting in Bash and Python, automation, version control with Git, running code inside Docker containers, and R-based statistical analysis.

### 📦 Main Features

* ✅ Linux CLI automation: history logging, environment detection, and file manipulations.
* 📁 Repository management using `git`, including branching, commits, and logs.
* 🐍 Python scripts for dynamic plant data visualization using matplotlib.
* 📊 Terminal-based Bash menu for CSV manipulation (create, update, delete, filter).
* 🧪 R scripting inside a Docker container to perform group-based analysis and data visualization.
* 🐳 Use of Docker containers for isolation and reproducibility.
* 🧠 Validation for scripts, input parameters, and runtime errors.
* 🗂 Organized outputs into structured folders by questions Q1–Q5.

### 📑 Structure

```
LINUX_COURSE_WORK/
├── Q1/         → Git log report, command outputs
├── Q2/         → Python script execution + updated outputs
├── Q3/         → Commit log tracking, bug report format
├── Q4/         → Plant data graphs from CSV input using Python
├── Q5/         → Interactive Bash menu (CSV), Docker integration, R container
├── README.md   → This file
```

### 🐍 Example Python Command

```bash
python plant_plots.py \
  --plant "Rose" \
  --height 50 55 60 65 70 \
  --leaf_count 35 40 45 50 55 \
  --dry_weight 2.0 2.2 2.5 2.7 3.0
```

### 📊 R-based Analysis in Docker

* Group by species and calculate mean weight
* Plot weight distribution by sex
* Count number of records per species/sex

All actions were logged to `R_outputs.txt_5` inside the Docker container.

---

## 📎 Technologies Used

* 🐧 Linux (WSL)
* 🐚 Bash scripting
* 🐍 Python + matplotlib
* 🐋 Docker
* 🧪 R (inside Docker)
* 🐙 Git & GitHub

---

## 💬 Author

BioData Track – Tel-Hai Academic College
Name : Mohamed Aga 

---

