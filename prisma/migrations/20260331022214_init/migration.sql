-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Company" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserCompany" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "role" TEXT NOT NULL,

    CONSTRAINT "UserCompany_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ImportDeclaration" (
    "id" TEXT NOT NULL,
    "companyId" TEXT NOT NULL,
    "diNumber" TEXT,
    "importerName" TEXT,
    "supplierName" TEXT,
    "totalValue" DOUBLE PRECISION,
    "status" TEXT NOT NULL,
    "rawJson" JSONB NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "processedAt" TIMESTAMP(3),

    CONSTRAINT "ImportDeclaration_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiItem" (
    "id" TEXT NOT NULL,
    "diId" TEXT NOT NULL,
    "productName" TEXT NOT NULL,
    "ncm" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "unitValue" DOUBLE PRECISION NOT NULL,
    "totalValue" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "DiItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DiTax" (
    "id" TEXT NOT NULL,
    "diId" TEXT NOT NULL,
    "ii" DOUBLE PRECISION,
    "ipi" DOUBLE PRECISION,
    "pis" DOUBLE PRECISION,
    "cofins" DOUBLE PRECISION,
    "icms" DOUBLE PRECISION,

    CONSTRAINT "DiTax_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Invoice" (
    "id" TEXT NOT NULL,
    "diId" TEXT NOT NULL,
    "invoiceNumber" TEXT,
    "xml" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Invoice_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "UserCompany" ADD CONSTRAINT "UserCompany_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserCompany" ADD CONSTRAINT "UserCompany_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ImportDeclaration" ADD CONSTRAINT "ImportDeclaration_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "Company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiItem" ADD CONSTRAINT "DiItem_diId_fkey" FOREIGN KEY ("diId") REFERENCES "ImportDeclaration"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DiTax" ADD CONSTRAINT "DiTax_diId_fkey" FOREIGN KEY ("diId") REFERENCES "ImportDeclaration"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Invoice" ADD CONSTRAINT "Invoice_diId_fkey" FOREIGN KEY ("diId") REFERENCES "ImportDeclaration"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
