
# Production-Grade CI/CD Pipeline for a Node.js API on GKE

This repository contains the complete Infrastructure as Code (Terraform) and CI/CD pipeline (Google Cloud Build) for a containerized NestJS backend application. The entire system is designed to be a repeatable, secure, and fully automated, from a `git push` to a live deployment on Google Kubernetes Engine.

Live Staging URL: `http://<YOUR_BACKEND_IP>:4000/`

---

## Architecture

This project follows a professional, GitOps-driven workflow:

`[GitHub] ---> [Cloud Build (CI/CD)] ---> [Terraform (IaC)] ---> [Helm] ---> [GKE (Staging & Prod)]`

---

## Tech Stack

*   Cloud: Google Cloud Platform (GCP)
*   Orchestration: Google Kubernetes Engine (GKE)
*   Containerization: Docker
*   Infrastructure as Code: Terraform
*   Kubernetes Packaging: Helm
*   CI/CD:Google Cloud Build (v2 Triggers)
*   Application: Node.js, NestJS, Prisma, PostgreSQL

---

## Key Features & DevOps Principles

This project was built to world-class standards, demonstrating mastery of the following DevOps principles:

*   Complete Automation: The entire build, push, and deploy lifecycle is 100% automated.
*   Infrastructure as Code: Every single cloud resource (VPC, GKE Cluster, IAM Service Accounts, Firewall rules, Secrets) is defined as code in Terraform for perfect reproducibility.
*   Multi-Environment Workflow:**
    *   The pipeline automatically deploys every push to the `main` branch to a Staging environment.
    *   Production deployments are triggered only by pushing a Git version tag (e.g., `v1.0.1`), ensuring deliberate and safe releases.
*   Secure Release Process: The production trigger is configured with a manual approval gate in Cloud Build, requiring human sign-off before any changes go live.
*   Optimized Containerization: A multi-stage `Dockerfile` is used to create a lean, secure, and fast-building production image, separating build-time dependencies from runtime dependencies.
*   Secret Management: Application secrets (like the `DATABASE_URL`) are securely managed in Google Secret Manager and safely projected into the Kubernetes cluster at deploy time. The secret value is never stored in the repository.
*   Advanced Security: The system uses the modern **Workload Identity** to grant pods granular, keyless access to Google Cloud services, following the Principle of Least Privilege.
*   Resilience and Scalability: The Kubernetes deployment is configured with a HorizontalPodAutoscaler (HPA) to automatically handle traffic spikes, and startup, liveness, and readiness probes to ensure the application is self-healing.

---

## The Debugging Journey

This project tells the story of a real-world debugging marathon, where I successfully diagnosed and solved complex, multi-layered issues related to:
*   Terraform state corruption and "ghost" resources.
*   Advanced IAM and Service Account permission failures.
*   Kubernetes pod failures, including `ImagePullBackOff` and `OOMKilled` (Out of Memory).
*   CI/CD pipeline race conditions and transient network errors.
*   Cloud provider API incompatibilities (Cloud Build v1 vs. v2 Triggers).
*   Application runtime configuration (`0.0.0.0` binding).

This project is a testament to a deep, practical, and battle-hardened understanding of modern cloud infrastructure.

