; ModuleID = 'test/testcudakernel1.cu'
target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"
target triple = "nvptx64-nvidia-cuda"

%struct.MyStruct = type { i32, float }
%struct.float4 = type { float, float, float, float }
%struct.hasArray = type { [4 x i32] }

@.str = private unnamed_addr constant [5 x i8] c"NONE\00", align 1
@_ZZ9testLocalPfE8myshared = internal unnamed_addr addrspace(3) global [32 x float] zeroinitializer, align 4
@_ZZ10testLocal2PfE8myshared = internal unnamed_addr addrspace(3) global [64 x float] zeroinitializer, align 4
@llvm.used = appending global [1 x i8*] [i8* bitcast (i32 ()* @_ZL21__nvvm_reflect_anchorv to i8*)], section "llvm.metadata"

; Function Attrs: nounwind readnone
define internal i32 @_ZL21__nvvm_reflect_anchorv() #0 {
  %1 = tail call i32 @__nvvm_reflect(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str, i64 0, i64 0)) #6
  ret i32 %1
}

; Function Attrs: nounwind readnone
declare i32 @__nvvm_reflect(i8*) #0

; Function Attrs: norecurse nounwind readnone
define float @_Z3barff(float %a, float %b) #1 {
  %1 = fadd float %a, %b
  ret float %1
}

; Function Attrs: norecurse nounwind
define void @_Z7incrvalPf(float* nocapture %a) #2 {
  %1 = load float, float* %a, align 4, !tbaa !37
  %2 = fadd float %1, 3.000000e+00
  store float %2, float* %a, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z3fooPf(float* nocapture %data) #2 {
  store float 1.230000e+02, float* %data, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z7use_tidPf(float* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %data, i64 %2
  store float 1.230000e+02, float* %3, align 4, !tbaa !37
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #3

; Function Attrs: norecurse nounwind
define void @_Z8use_tid2Pi(i32* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds i32, i32* %data, i64 %2
  %4 = load i32, i32* %3, align 4, !tbaa !41
  %5 = add nsw i32 %4, %1
  store i32 %5, i32* %3, align 4, !tbaa !41
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z10copy_floatPf(float* nocapture %a) #2 {
  %1 = getelementptr inbounds float, float* %a, i64 1
  %2 = bitcast float* %1 to i32*
  %3 = load i32, i32* %2, align 4, !tbaa !37
  %4 = bitcast float* %a to i32*
  store i32 %3, i32* %4, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z11use_blockidPf(float* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.ctaid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %data, i64 %2
  store float 1.230000e+02, float* %3, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z11use_griddimPf(float* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.nctaid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %data, i64 %2
  store float 1.230000e+02, float* %3, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z12use_blockdimPf(float* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.ntid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %data, i64 %2
  store float 1.230000e+02, float* %3, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z13use_template1PfPi(float* nocapture %data, i32* nocapture %intdata) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %14

; <label>:3                                       ; preds = %0
  %4 = getelementptr inbounds float, float* %data, i64 1
  %5 = load float, float* %4, align 4, !tbaa !37
  %6 = getelementptr inbounds float, float* %data, i64 2
  %7 = load float, float* %6, align 4, !tbaa !37
  %8 = fadd float %5, %7
  store float %8, float* %data, align 4, !tbaa !37
  %9 = getelementptr inbounds i32, i32* %intdata, i64 1
  %10 = load i32, i32* %9, align 4, !tbaa !41
  %11 = getelementptr inbounds i32, i32* %intdata, i64 2
  %12 = load i32, i32* %11, align 4, !tbaa !41
  %13 = add nsw i32 %12, %10
  store i32 %13, i32* %intdata, align 4, !tbaa !41
  br label %14

; <label>:14                                      ; preds = %3, %0
  ret void
}

define void @_Z13someops_floatPf(float* nocapture %data) #4 {
  %1 = getelementptr inbounds float, float* %data, i64 1
  %2 = load float, float* %1, align 4, !tbaa !37
  %3 = getelementptr inbounds float, float* %data, i64 2
  %4 = load float, float* %3, align 4, !tbaa !37
  %5 = fsub float %2, %4
  %6 = fdiv float %2, %4
  %7 = fadd float %5, %6
  %8 = fmul float %4, %2
  %9 = fadd float %7, %8
  store float %9, float* %data, align 4, !tbaa !37
  %10 = tail call float @_Z15our_pretend_logf(float %2)
  %11 = load float, float* %data, align 4, !tbaa !37
  %12 = fadd float %10, %11
  store float %12, float* %data, align 4, !tbaa !37
  %13 = load float, float* %1, align 4, !tbaa !37
  %14 = tail call float @_Z15our_pretend_expf(float %13)
  %15 = load float, float* %data, align 4, !tbaa !37
  %16 = fadd float %14, %15
  store float %16, float* %data, align 4, !tbaa !37
  %17 = load float, float* %1, align 4, !tbaa !37
  %18 = tail call float @_Z16our_pretend_tanhf(float %17)
  %19 = load float, float* %data, align 4, !tbaa !37
  %20 = fadd float %18, %19
  store float %20, float* %data, align 4, !tbaa !37
  %21 = load float, float* %1, align 4, !tbaa !37
  %22 = tail call float @_ZSt4sqrtf(float %21)
  %23 = load float, float* %data, align 4, !tbaa !37
  %24 = fsub float %23, %22
  store float %24, float* %data, align 4, !tbaa !37
  ret void
}

declare float @_Z15our_pretend_logf(float) #4

declare float @_Z15our_pretend_expf(float) #4

declare float @_Z16our_pretend_tanhf(float) #4

declare float @_ZSt4sqrtf(float) #4

; Function Attrs: norecurse nounwind
define void @_Z11someops_intPi(i32* nocapture %data) #2 {
  %1 = getelementptr inbounds i32, i32* %data, i64 1
  %2 = load i32, i32* %1, align 4, !tbaa !41
  %3 = getelementptr inbounds i32, i32* %data, i64 2
  %4 = load i32, i32* %3, align 4, !tbaa !41
  %5 = sdiv i32 %2, %4
  %6 = add i32 %2, %5
  %7 = add i32 %6, %2
  %8 = mul nsw i32 %4, %2
  %9 = add nsw i32 %8, %7
  %10 = shl i32 %2, %4
  %11 = add nsw i32 %10, %9
  %12 = ashr i32 %2, %4
  %13 = add nsw i32 %12, %11
  store i32 %13, i32* %data, align 4, !tbaa !41
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z14testbooleanopsPi(i32* nocapture %data) #2 {
  %1 = load i32, i32* %data, align 4, !tbaa !41
  %2 = icmp sgt i32 %1, 0
  %3 = getelementptr inbounds i32, i32* %data, i64 1
  %4 = load i32, i32* %3, align 4, !tbaa !41
  %5 = icmp slt i32 %4, 0
  %6 = and i1 %2, %5
  %7 = zext i1 %6 to i32
  %8 = getelementptr inbounds i32, i32* %data, i64 2
  store i32 %7, i32* %8, align 4, !tbaa !41
  %9 = or i1 %2, %5
  %10 = zext i1 %9 to i32
  %11 = getelementptr inbounds i32, i32* %data, i64 3
  store i32 %10, i32* %11, align 4, !tbaa !41
  %12 = zext i1 %2 to i32
  %13 = xor i32 %12, 1
  %14 = getelementptr inbounds i32, i32* %data, i64 4
  store i32 %13, i32* %14, align 4, !tbaa !41
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z26testcomparisons_int_signedPi(i32* nocapture %data) #2 {
  %1 = load i32, i32* %data, align 4, !tbaa !41
  %2 = getelementptr inbounds i32, i32* %data, i64 1
  %3 = load i32, i32* %2, align 4, !tbaa !41
  %4 = icmp sge i32 %1, %3
  %5 = zext i1 %4 to i32
  %6 = getelementptr inbounds i32, i32* %data, i64 5
  store i32 %5, i32* %6, align 4, !tbaa !41
  %7 = icmp sle i32 %1, %3
  %8 = zext i1 %7 to i32
  %9 = getelementptr inbounds i32, i32* %data, i64 6
  store i32 %8, i32* %9, align 4, !tbaa !41
  %10 = icmp sgt i32 %1, %3
  %11 = zext i1 %10 to i32
  %12 = getelementptr inbounds i32, i32* %data, i64 7
  store i32 %11, i32* %12, align 4, !tbaa !41
  %13 = icmp slt i32 %1, %3
  %14 = zext i1 %13 to i32
  %15 = getelementptr inbounds i32, i32* %data, i64 8
  store i32 %14, i32* %15, align 4, !tbaa !41
  %16 = icmp eq i32 %1, %3
  %17 = zext i1 %16 to i32
  %18 = getelementptr inbounds i32, i32* %data, i64 9
  store i32 %17, i32* %18, align 4, !tbaa !41
  %19 = icmp ne i32 %1, %3
  %20 = zext i1 %19 to i32
  %21 = getelementptr inbounds i32, i32* %data, i64 10
  store i32 %20, i32* %21, align 4, !tbaa !41
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z21testcomparisons_floatPf(float* nocapture %data) #2 {
  %1 = load float, float* %data, align 4, !tbaa !37
  %2 = getelementptr inbounds float, float* %data, i64 1
  %3 = load float, float* %2, align 4, !tbaa !37
  %4 = fcmp oge float %1, %3
  %5 = uitofp i1 %4 to float
  %6 = getelementptr inbounds float, float* %data, i64 5
  store float %5, float* %6, align 4, !tbaa !37
  %7 = fcmp ole float %1, %3
  %8 = uitofp i1 %7 to float
  %9 = getelementptr inbounds float, float* %data, i64 6
  store float %8, float* %9, align 4, !tbaa !37
  %10 = fcmp ogt float %1, %3
  %11 = uitofp i1 %10 to float
  %12 = getelementptr inbounds float, float* %data, i64 7
  store float %11, float* %12, align 4, !tbaa !37
  %13 = fcmp olt float %1, %3
  %14 = uitofp i1 %13 to float
  %15 = getelementptr inbounds float, float* %data, i64 8
  store float %14, float* %15, align 4, !tbaa !37
  %16 = fcmp oeq float %1, %3
  %17 = uitofp i1 %16 to float
  %18 = getelementptr inbounds float, float* %data, i64 9
  store float %17, float* %18, align 4, !tbaa !37
  %19 = fcmp une float %1, %3
  %20 = uitofp i1 %19 to float
  %21 = getelementptr inbounds float, float* %data, i64 10
  store float %20, float* %21, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z15testsyncthreadsPf(float* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %data, i64 %2
  %4 = load float, float* %3, align 4, !tbaa !37
  %5 = fmul float %4, 2.000000e+00
  store float %5, float* %3, align 4, !tbaa !37
  tail call void @llvm.cuda.syncthreads() #8
  %6 = add nsw i32 %1, 1
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds float, float* %data, i64 %7
  %9 = load float, float* %8, align 4, !tbaa !37
  %10 = fadd float %9, 2.000000e+00
  store float %10, float* %8, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind readonly
define void @_Z11testDoWhilePii(i32* nocapture %data, i32 %N) #5 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  br label %2

; <label>:2                                       ; preds = %2, %0
  %p.0 = phi i32 [ %1, %0 ], [ %3, %2 ]
  %3 = add nsw i32 %p.0, 1
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds i32, i32* %data, i64 %4
  %6 = load i32, i32* %5, align 4, !tbaa !41
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %2

; <label>:8                                       ; preds = %2
  ret void
}

; Function Attrs: norecurse nounwind readonly
define void @_Z9testWhilePii(i32* nocapture %data, i32 %N) #5 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  br label %2

; <label>:2                                       ; preds = %2, %0
  %p.0 = phi i32 [ %1, %0 ], [ %7, %2 ]
  %3 = sext i32 %p.0 to i64
  %4 = getelementptr inbounds i32, i32* %data, i64 %3
  %5 = load i32, i32* %4, align 4, !tbaa !41
  %6 = icmp eq i32 %5, 0
  %7 = add nsw i32 %p.0, 1
  br i1 %6, label %8, label %2

; <label>:8                                       ; preds = %2
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z6testIfPii(i32* nocapture %data, i32 %N) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = icmp slt i32 %1, %N
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %0
  %4 = sext i32 %1 to i64
  %5 = getelementptr inbounds i32, i32* %data, i64 %4
  %6 = load i32, i32* %5, align 4, !tbaa !41
  %7 = shl nsw i32 %6, 1
  store i32 %7, i32* %5, align 4, !tbaa !41
  br label %8

; <label>:8                                       ; preds = %3, %0
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z10testIfElsePii(i32* nocapture %data, i32 %N) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = icmp slt i32 %1, %N
  %3 = sext i32 %1 to i64
  %4 = getelementptr inbounds i32, i32* %data, i64 %3
  %5 = load i32, i32* %4, align 4, !tbaa !41
  br i1 %2, label %6, label %13

; <label>:6                                       ; preds = %0
  %7 = shl nsw i32 %5, 1
  store i32 %7, i32* %4, align 4, !tbaa !41
  %8 = add nsw i32 %1, 3
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds i32, i32* %data, i64 %9
  %11 = load i32, i32* %10, align 4, !tbaa !41
  %12 = shl nsw i32 %11, 1
  store i32 %12, i32* %10, align 4, !tbaa !41
  br label %20

; <label>:13                                      ; preds = %0
  %14 = add nsw i32 %5, -20
  store i32 %14, i32* %4, align 4, !tbaa !41
  %15 = add nsw i32 %1, 5
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i32, i32* %data, i64 %16
  %18 = load i32, i32* %17, align 4, !tbaa !41
  %19 = add nsw i32 %18, -20
  store i32 %19, i32* %17, align 4, !tbaa !41
  br label %20

; <label>:20                                      ; preds = %13, %6
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z11testTernaryPf(float* nocapture %data) #2 {
  %1 = getelementptr inbounds float, float* %data, i64 1
  %2 = load float, float* %1, align 4, !tbaa !37
  %3 = fcmp ogt float %2, 0.000000e+00
  %4 = getelementptr inbounds float, float* %data, i64 2
  %5 = getelementptr inbounds float, float* %data, i64 3
  %.in = select i1 %3, float* %4, float* %5
  %6 = bitcast float* %.in to i32*
  %7 = load i32, i32* %6, align 4, !tbaa !37
  %8 = bitcast float* %data to i32*
  store i32 %7, i32* %8, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z7testForPfi(float* nocapture %data, i32 %N) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %.preheader, label %31

.preheader:                                       ; preds = %0
  %3 = icmp sgt i32 %N, 0
  br i1 %3, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %.preheader
  %4 = add i32 %N, -1
  %xtraiter = and i32 %N, 3
  %lcmp.mod = icmp eq i32 %xtraiter, 0
  br i1 %lcmp.mod, label %.lr.ph.preheader.split, label %.lr.ph.prol.preheader

.lr.ph.prol.preheader:                            ; preds = %.lr.ph.preheader
  br label %.lr.ph.prol

.lr.ph.prol:                                      ; preds = %.lr.ph.prol.preheader, %.lr.ph.prol
  %i.02.prol = phi i32 [ %9, %.lr.ph.prol ], [ 0, %.lr.ph.prol.preheader ]
  %sum.01.prol = phi float [ %8, %.lr.ph.prol ], [ 0.000000e+00, %.lr.ph.prol.preheader ]
  %prol.iter = phi i32 [ %prol.iter.sub, %.lr.ph.prol ], [ %xtraiter, %.lr.ph.prol.preheader ]
  %5 = sext i32 %i.02.prol to i64
  %6 = getelementptr inbounds float, float* %data, i64 %5
  %7 = load float, float* %6, align 4, !tbaa !37
  %8 = fadd float %sum.01.prol, %7
  %9 = add nuw nsw i32 %i.02.prol, 1
  %prol.iter.sub = add i32 %prol.iter, -1
  %prol.iter.cmp = icmp eq i32 %prol.iter.sub, 0
  br i1 %prol.iter.cmp, label %.lr.ph.preheader.split.loopexit, label %.lr.ph.prol, !llvm.loop !43

.lr.ph.preheader.split.loopexit:                  ; preds = %.lr.ph.prol
  %.lcssa5 = phi i32 [ %9, %.lr.ph.prol ]
  %.lcssa4 = phi float [ %8, %.lr.ph.prol ]
  br label %.lr.ph.preheader.split

.lr.ph.preheader.split:                           ; preds = %.lr.ph.preheader.split.loopexit, %.lr.ph.preheader
  %.lcssa.unr = phi float [ undef, %.lr.ph.preheader ], [ %.lcssa4, %.lr.ph.preheader.split.loopexit ]
  %i.02.unr = phi i32 [ 0, %.lr.ph.preheader ], [ %.lcssa5, %.lr.ph.preheader.split.loopexit ]
  %sum.01.unr = phi float [ 0.000000e+00, %.lr.ph.preheader ], [ %.lcssa4, %.lr.ph.preheader.split.loopexit ]
  %10 = icmp ult i32 %4, 3
  br i1 %10, label %._crit_edge.loopexit, label %.lr.ph.preheader.split.split

.lr.ph.preheader.split.split:                     ; preds = %.lr.ph.preheader.split
  br label %.lr.ph

._crit_edge.loopexit.unr-lcssa:                   ; preds = %.lr.ph
  %.lcssa3 = phi float [ %29, %.lr.ph ]
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph.preheader.split, %._crit_edge.loopexit.unr-lcssa
  %.lcssa = phi float [ %.lcssa.unr, %.lr.ph.preheader.split ], [ %.lcssa3, %._crit_edge.loopexit.unr-lcssa ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.preheader
  %sum.0.lcssa = phi float [ 0.000000e+00, %.preheader ], [ %.lcssa, %._crit_edge.loopexit ]
  store float %sum.0.lcssa, float* %data, align 4, !tbaa !37
  br label %31

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader.split.split
  %i.02 = phi i32 [ %i.02.unr, %.lr.ph.preheader.split.split ], [ %30, %.lr.ph ]
  %sum.01 = phi float [ %sum.01.unr, %.lr.ph.preheader.split.split ], [ %29, %.lr.ph ]
  %11 = sext i32 %i.02 to i64
  %12 = getelementptr inbounds float, float* %data, i64 %11
  %13 = load float, float* %12, align 4, !tbaa !37
  %14 = fadd float %sum.01, %13
  %15 = add nuw nsw i32 %i.02, 1
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds float, float* %data, i64 %16
  %18 = load float, float* %17, align 4, !tbaa !37
  %19 = fadd float %14, %18
  %20 = add nsw i32 %i.02, 2
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds float, float* %data, i64 %21
  %23 = load float, float* %22, align 4, !tbaa !37
  %24 = fadd float %19, %23
  %25 = add nsw i32 %i.02, 3
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds float, float* %data, i64 %26
  %28 = load float, float* %27, align 4, !tbaa !37
  %29 = fadd float %24, %28
  %30 = add nsw i32 %i.02, 4
  %exitcond.3 = icmp eq i32 %30, %N
  br i1 %exitcond.3, label %._crit_edge.loopexit.unr-lcssa, label %.lr.ph

; <label>:31                                      ; preds = %._crit_edge, %0
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z8setValuePfif(float* nocapture %data, i32 %idx, float %value) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = sext i32 %idx to i64
  %5 = getelementptr inbounds float, float* %data, i64 %4
  store float %value, float* %5, align 4, !tbaa !37
  br label %6

; <label>:6                                       ; preds = %3, %0
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z11testStructsP8MyStructPfPi(%struct.MyStruct* nocapture readonly %structs, float* nocapture %float_data, i32* nocapture %int_data) #2 {
  %1 = getelementptr inbounds %struct.MyStruct, %struct.MyStruct* %structs, i64 0, i32 0
  %2 = load i32, i32* %1, align 4, !tbaa !45
  store i32 %2, i32* %int_data, align 4, !tbaa !41
  %3 = getelementptr inbounds %struct.MyStruct, %struct.MyStruct* %structs, i64 0, i32 1
  %4 = bitcast float* %3 to i32*
  %5 = load i32, i32* %4, align 4, !tbaa !47
  %6 = bitcast float* %float_data to i32*
  store i32 %5, i32* %6, align 4, !tbaa !37
  %7 = getelementptr inbounds %struct.MyStruct, %struct.MyStruct* %structs, i64 1, i32 1
  %8 = bitcast float* %7 to i32*
  %9 = load i32, i32* %8, align 4, !tbaa !47
  %10 = getelementptr inbounds float, float* %float_data, i64 1
  %11 = bitcast float* %10 to i32*
  store i32 %9, i32* %11, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z10testFloat4P6float4(%struct.float4* nocapture %data) #2 {
  %1 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 1, i32 0
  %2 = bitcast float* %1 to i32*
  %3 = load i32, i32* %2, align 16
  %4 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 1, i32 2
  %5 = load float, float* %4, align 8
  %6 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 1, i32 3
  %7 = load float, float* %6, align 4
  %8 = fmul float %5, %7
  %9 = bitcast %struct.float4* %data to i32*
  store i32 %3, i32* %9, align 16
  %10 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 0, i32 1
  store float %8, float* %10, align 4
  %11 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 0, i32 2
  store float %5, float* %11, align 8
  %12 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 0, i32 3
  store float %7, float* %12, align 4
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: norecurse nounwind
define void @_Z16testFloat4_test2P6float4(%struct.float4* nocapture %data) #2 {
  %1 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 1
  %2 = bitcast %struct.float4* %data to i8*
  %3 = bitcast %struct.float4* %1 to i8*
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 16, i32 16, i1 false), !tbaa.struct !48
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z16testFloat4_test3P6float4(%struct.float4* nocapture %data) #2 {
  %privateFloats = alloca [32 x %struct.float4], align 16
  %1 = bitcast [32 x %struct.float4]* %privateFloats to i8*
  call void @llvm.lifetime.start(i64 512, i8* %1) #8
  br label %2

; <label>:2                                       ; preds = %2, %0
  %i.03 = phi i32 [ 0, %0 ], [ %26, %2 ]
  %3 = sext i32 %i.03 to i64
  %4 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %3
  %5 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %3
  %6 = bitcast %struct.float4* %4 to i8*
  %7 = bitcast %struct.float4* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* %7, i64 16, i32 16, i1 false), !tbaa.struct !48
  %8 = or i32 %i.03, 1
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %9
  %11 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %9
  %12 = bitcast %struct.float4* %10 to i8*
  %13 = bitcast %struct.float4* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* %13, i64 16, i32 16, i1 false), !tbaa.struct !48
  %14 = or i32 %i.03, 2
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %15
  %17 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %15
  %18 = bitcast %struct.float4* %16 to i8*
  %19 = bitcast %struct.float4* %17 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 16, i32 16, i1 false), !tbaa.struct !48
  %20 = or i32 %i.03, 3
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %21
  %23 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %21
  %24 = bitcast %struct.float4* %22 to i8*
  %25 = bitcast %struct.float4* %23 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %24, i8* %25, i64 16, i32 16, i1 false), !tbaa.struct !48
  %26 = add nsw i32 %i.03, 4
  %exitcond4.3 = icmp eq i32 %26, 32
  br i1 %exitcond4.3, label %.preheader.preheader, label %2

.preheader.preheader:                             ; preds = %2
  br label %.preheader

; <label>:27                                      ; preds = %.preheader
  call void @llvm.lifetime.end(i64 512, i8* nonnull %1) #8
  ret void

.preheader:                                       ; preds = %.preheader, %.preheader.preheader
  %i1.02 = phi i32 [ 0, %.preheader.preheader ], [ %49, %.preheader ]
  %28 = or i32 %i1.02, 1
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %29
  %31 = sext i32 %i1.02 to i64
  %32 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %31
  %33 = bitcast %struct.float4* %30 to i8*
  %34 = bitcast %struct.float4* %32 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %33, i8* %34, i64 16, i32 16, i1 false), !tbaa.struct !48
  %35 = or i32 %i1.02, 2
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %36
  %38 = sext i32 %28 to i64
  %39 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %38
  %40 = bitcast %struct.float4* %37 to i8*
  %41 = bitcast %struct.float4* %39 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %40, i8* %41, i64 16, i32 16, i1 false), !tbaa.struct !48
  %42 = or i32 %i1.02, 3
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %43
  %45 = sext i32 %35 to i64
  %46 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %45
  %47 = bitcast %struct.float4* %44 to i8*
  %48 = bitcast %struct.float4* %46 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %47, i8* %48, i64 16, i32 16, i1 false), !tbaa.struct !48
  %49 = add nsw i32 %i1.02, 4
  %50 = sext i32 %49 to i64
  %51 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 %50
  %52 = sext i32 %42 to i64
  %53 = getelementptr inbounds [32 x %struct.float4], [32 x %struct.float4]* %privateFloats, i64 0, i64 %52
  %54 = bitcast %struct.float4* %51 to i8*
  %55 = bitcast %struct.float4* %53 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %54, i8* %55, i64 16, i32 16, i1 false), !tbaa.struct !48
  %exitcond.3 = icmp eq i32 %49, 32
  br i1 %exitcond.3, label %27, label %.preheader
}

; Function Attrs: norecurse nounwind
define void @_Z9testLocalPf(float* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %data, i64 %2
  %4 = bitcast float* %3 to i32*
  %5 = load i32, i32* %4, align 4, !tbaa !37
  %6 = getelementptr inbounds [32 x float], [32 x float] addrspace(3)* @_ZZ9testLocalPfE8myshared, i64 0, i64 %2
  %7 = bitcast float addrspace(3)* %6 to i32 addrspace(3)*
  %8 = addrspacecast i32 addrspace(3)* %7 to i32*
  store i32 %5, i32* %8, align 4, !tbaa !37
  %9 = add nsw i32 %1, 1
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [32 x float], [32 x float] addrspace(3)* @_ZZ9testLocalPfE8myshared, i64 0, i64 %10
  %12 = bitcast float addrspace(3)* %11 to i32 addrspace(3)*
  %13 = addrspacecast i32 addrspace(3)* %12 to i32*
  %14 = load i32, i32* %13, align 4, !tbaa !37
  %15 = bitcast float* %data to i32*
  store i32 %14, i32* %15, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z10testLocal2Pf(float* nocapture %data) #2 {
  %1 = tail call i32 @llvm.ptx.read.tid.x() #8
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds float, float* %data, i64 %2
  %4 = bitcast float* %3 to i32*
  %5 = load i32, i32* %4, align 4, !tbaa !37
  %6 = getelementptr inbounds [64 x float], [64 x float] addrspace(3)* @_ZZ10testLocal2PfE8myshared, i64 0, i64 %2
  %7 = bitcast float addrspace(3)* %6 to i32 addrspace(3)*
  %8 = addrspacecast i32 addrspace(3)* %7 to i32*
  store i32 %5, i32* %8, align 4, !tbaa !37
  %9 = add nsw i32 %1, 1
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [64 x float], [64 x float] addrspace(3)* @_ZZ10testLocal2PfE8myshared, i64 0, i64 %10
  %12 = bitcast float addrspace(3)* %11 to i32 addrspace(3)*
  %13 = addrspacecast i32 addrspace(3)* %12 to i32*
  %14 = load i32, i32* %13, align 4, !tbaa !37
  %15 = bitcast float* %data to i32*
  store i32 %14, i32* %15, align 4, !tbaa !37
  %16 = load i32, i32* %4, align 4, !tbaa !37
  store i32 %16, i32* %13, align 4, !tbaa !37
  %17 = load i32, i32* %8, align 4, !tbaa !37
  %18 = getelementptr inbounds float, float* %data, i64 1
  %19 = bitcast float* %18 to i32*
  store i32 %17, i32* %19, align 4, !tbaa !37
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z9testArrayPf(float* nocapture %data) #2 {
  %privateFloats = alloca [32 x float], align 4
  %1 = bitcast [32 x float]* %privateFloats to i8*
  call void @llvm.lifetime.start(i64 128, i8* %1) #8
  br label %2

; <label>:2                                       ; preds = %2, %0
  %i.03 = phi i32 [ 0, %0 ], [ %38, %2 ]
  %3 = mul nuw nsw i32 %i.03, 3
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds float, float* %data, i64 %4
  %6 = bitcast float* %5 to i32*
  %7 = load i32, i32* %6, align 4, !tbaa !37
  %8 = sext i32 %i.03 to i64
  %9 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 %8
  %10 = bitcast float* %9 to i32*
  store i32 %7, i32* %10, align 4, !tbaa !37
  %11 = or i32 %i.03, 1
  %12 = mul nuw nsw i32 %11, 3
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds float, float* %data, i64 %13
  %15 = bitcast float* %14 to i32*
  %16 = load i32, i32* %15, align 4, !tbaa !37
  %17 = sext i32 %11 to i64
  %18 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 %17
  %19 = bitcast float* %18 to i32*
  store i32 %16, i32* %19, align 4, !tbaa !37
  %20 = or i32 %i.03, 2
  %21 = mul nuw nsw i32 %20, 3
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds float, float* %data, i64 %22
  %24 = bitcast float* %23 to i32*
  %25 = load i32, i32* %24, align 4, !tbaa !37
  %26 = sext i32 %20 to i64
  %27 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 %26
  %28 = bitcast float* %27 to i32*
  store i32 %25, i32* %28, align 4, !tbaa !37
  %29 = or i32 %i.03, 3
  %30 = mul nuw nsw i32 %29, 3
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds float, float* %data, i64 %31
  %33 = bitcast float* %32 to i32*
  %34 = load i32, i32* %33, align 4, !tbaa !37
  %35 = sext i32 %29 to i64
  %36 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 %35
  %37 = bitcast float* %36 to i32*
  store i32 %34, i32* %37, align 4, !tbaa !37
  %38 = add nsw i32 %i.03, 4
  %exitcond.3 = icmp eq i32 %38, 32
  br i1 %exitcond.3, label %.preheader.preheader, label %2

.preheader.preheader:                             ; preds = %2
  %39 = bitcast [32 x float]* %privateFloats to i32*
  %40 = load i32, i32* %39, align 4, !tbaa !37
  %41 = getelementptr inbounds float, float* %data, i64 1
  %42 = bitcast float* %41 to i32*
  store i32 %40, i32* %42, align 4, !tbaa !37
  %43 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 2
  %44 = bitcast float* %43 to i32*
  %45 = load i32, i32* %44, align 4, !tbaa !37
  %46 = getelementptr inbounds float, float* %data, i64 3
  %47 = bitcast float* %46 to i32*
  store i32 %45, i32* %47, align 4, !tbaa !37
  %48 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 4
  %49 = bitcast float* %48 to i32*
  %50 = load i32, i32* %49, align 4, !tbaa !37
  %51 = getelementptr inbounds float, float* %data, i64 5
  %52 = bitcast float* %51 to i32*
  store i32 %50, i32* %52, align 4, !tbaa !37
  %53 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 6
  %54 = bitcast float* %53 to i32*
  %55 = load i32, i32* %54, align 4, !tbaa !37
  %56 = getelementptr inbounds float, float* %data, i64 7
  %57 = bitcast float* %56 to i32*
  store i32 %55, i32* %57, align 4, !tbaa !37
  %58 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 8
  %59 = bitcast float* %58 to i32*
  %60 = load i32, i32* %59, align 4, !tbaa !37
  %61 = getelementptr inbounds float, float* %data, i64 9
  %62 = bitcast float* %61 to i32*
  store i32 %60, i32* %62, align 4, !tbaa !37
  %63 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 10
  %64 = bitcast float* %63 to i32*
  %65 = load i32, i32* %64, align 4, !tbaa !37
  %66 = getelementptr inbounds float, float* %data, i64 11
  %67 = bitcast float* %66 to i32*
  store i32 %65, i32* %67, align 4, !tbaa !37
  %68 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 12
  %69 = bitcast float* %68 to i32*
  %70 = load i32, i32* %69, align 4, !tbaa !37
  %71 = getelementptr inbounds float, float* %data, i64 13
  %72 = bitcast float* %71 to i32*
  store i32 %70, i32* %72, align 4, !tbaa !37
  %73 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 14
  %74 = bitcast float* %73 to i32*
  %75 = load i32, i32* %74, align 4, !tbaa !37
  %76 = getelementptr inbounds float, float* %data, i64 15
  %77 = bitcast float* %76 to i32*
  store i32 %75, i32* %77, align 4, !tbaa !37
  %78 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 16
  %79 = bitcast float* %78 to i32*
  %80 = load i32, i32* %79, align 4, !tbaa !37
  %81 = getelementptr inbounds float, float* %data, i64 17
  %82 = bitcast float* %81 to i32*
  store i32 %80, i32* %82, align 4, !tbaa !37
  %83 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 18
  %84 = bitcast float* %83 to i32*
  %85 = load i32, i32* %84, align 4, !tbaa !37
  %86 = getelementptr inbounds float, float* %data, i64 19
  %87 = bitcast float* %86 to i32*
  store i32 %85, i32* %87, align 4, !tbaa !37
  %88 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 20
  %89 = bitcast float* %88 to i32*
  %90 = load i32, i32* %89, align 4, !tbaa !37
  %91 = getelementptr inbounds float, float* %data, i64 21
  %92 = bitcast float* %91 to i32*
  store i32 %90, i32* %92, align 4, !tbaa !37
  %93 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 22
  %94 = bitcast float* %93 to i32*
  %95 = load i32, i32* %94, align 4, !tbaa !37
  %96 = getelementptr inbounds float, float* %data, i64 23
  %97 = bitcast float* %96 to i32*
  store i32 %95, i32* %97, align 4, !tbaa !37
  %98 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 24
  %99 = bitcast float* %98 to i32*
  %100 = load i32, i32* %99, align 4, !tbaa !37
  %101 = getelementptr inbounds float, float* %data, i64 25
  %102 = bitcast float* %101 to i32*
  store i32 %100, i32* %102, align 4, !tbaa !37
  %103 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 26
  %104 = bitcast float* %103 to i32*
  %105 = load i32, i32* %104, align 4, !tbaa !37
  %106 = getelementptr inbounds float, float* %data, i64 27
  %107 = bitcast float* %106 to i32*
  store i32 %105, i32* %107, align 4, !tbaa !37
  %108 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 28
  %109 = bitcast float* %108 to i32*
  %110 = load i32, i32* %109, align 4, !tbaa !37
  %111 = getelementptr inbounds float, float* %data, i64 29
  %112 = bitcast float* %111 to i32*
  store i32 %110, i32* %112, align 4, !tbaa !37
  %113 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 30
  %114 = bitcast float* %113 to i32*
  %115 = load i32, i32* %114, align 4, !tbaa !37
  %116 = getelementptr inbounds float, float* %data, i64 31
  %117 = bitcast float* %116 to i32*
  store i32 %115, i32* %117, align 4, !tbaa !37
  call void @llvm.lifetime.end(i64 128, i8* nonnull %1) #8
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z10testmemcpyPf(float* nocapture %data) #2 {
.preheader.preheader:
  %data4 = bitcast float* %data to i8*
  %privateFloats = alloca [32 x float], align 4
  %0 = bitcast [32 x float]* %privateFloats to i8*
  call void @llvm.lifetime.start(i64 128, i8* %0) #8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %data4, i64 128, i32 4, i1 false)
  %1 = bitcast [32 x float]* %privateFloats to i32*
  %2 = load i32, i32* %1, align 4, !tbaa !37
  %3 = bitcast float* %data to i32*
  store i32 %2, i32* %3, align 4, !tbaa !37
  %4 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 2
  %5 = bitcast float* %4 to i32*
  %6 = load i32, i32* %5, align 4, !tbaa !37
  %7 = getelementptr inbounds float, float* %data, i64 2
  %8 = bitcast float* %7 to i32*
  store i32 %6, i32* %8, align 4, !tbaa !37
  %9 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 4
  %10 = bitcast float* %9 to i32*
  %11 = load i32, i32* %10, align 4, !tbaa !37
  %12 = getelementptr inbounds float, float* %data, i64 4
  %13 = bitcast float* %12 to i32*
  store i32 %11, i32* %13, align 4, !tbaa !37
  %14 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 6
  %15 = bitcast float* %14 to i32*
  %16 = load i32, i32* %15, align 4, !tbaa !37
  %17 = getelementptr inbounds float, float* %data, i64 6
  %18 = bitcast float* %17 to i32*
  store i32 %16, i32* %18, align 4, !tbaa !37
  %19 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 8
  %20 = bitcast float* %19 to i32*
  %21 = load i32, i32* %20, align 4, !tbaa !37
  %22 = getelementptr inbounds float, float* %data, i64 8
  %23 = bitcast float* %22 to i32*
  store i32 %21, i32* %23, align 4, !tbaa !37
  %24 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 10
  %25 = bitcast float* %24 to i32*
  %26 = load i32, i32* %25, align 4, !tbaa !37
  %27 = getelementptr inbounds float, float* %data, i64 10
  %28 = bitcast float* %27 to i32*
  store i32 %26, i32* %28, align 4, !tbaa !37
  %29 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 12
  %30 = bitcast float* %29 to i32*
  %31 = load i32, i32* %30, align 4, !tbaa !37
  %32 = getelementptr inbounds float, float* %data, i64 12
  %33 = bitcast float* %32 to i32*
  store i32 %31, i32* %33, align 4, !tbaa !37
  %34 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 14
  %35 = bitcast float* %34 to i32*
  %36 = load i32, i32* %35, align 4, !tbaa !37
  %37 = getelementptr inbounds float, float* %data, i64 14
  %38 = bitcast float* %37 to i32*
  store i32 %36, i32* %38, align 4, !tbaa !37
  %39 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 16
  %40 = bitcast float* %39 to i32*
  %41 = load i32, i32* %40, align 4, !tbaa !37
  %42 = getelementptr inbounds float, float* %data, i64 16
  %43 = bitcast float* %42 to i32*
  store i32 %41, i32* %43, align 4, !tbaa !37
  %44 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 18
  %45 = bitcast float* %44 to i32*
  %46 = load i32, i32* %45, align 4, !tbaa !37
  %47 = getelementptr inbounds float, float* %data, i64 18
  %48 = bitcast float* %47 to i32*
  store i32 %46, i32* %48, align 4, !tbaa !37
  %49 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 20
  %50 = bitcast float* %49 to i32*
  %51 = load i32, i32* %50, align 4, !tbaa !37
  %52 = getelementptr inbounds float, float* %data, i64 20
  %53 = bitcast float* %52 to i32*
  store i32 %51, i32* %53, align 4, !tbaa !37
  %54 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 22
  %55 = bitcast float* %54 to i32*
  %56 = load i32, i32* %55, align 4, !tbaa !37
  %57 = getelementptr inbounds float, float* %data, i64 22
  %58 = bitcast float* %57 to i32*
  store i32 %56, i32* %58, align 4, !tbaa !37
  %59 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 24
  %60 = bitcast float* %59 to i32*
  %61 = load i32, i32* %60, align 4, !tbaa !37
  %62 = getelementptr inbounds float, float* %data, i64 24
  %63 = bitcast float* %62 to i32*
  store i32 %61, i32* %63, align 4, !tbaa !37
  %64 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 26
  %65 = bitcast float* %64 to i32*
  %66 = load i32, i32* %65, align 4, !tbaa !37
  %67 = getelementptr inbounds float, float* %data, i64 26
  %68 = bitcast float* %67 to i32*
  store i32 %66, i32* %68, align 4, !tbaa !37
  %69 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 28
  %70 = bitcast float* %69 to i32*
  %71 = load i32, i32* %70, align 4, !tbaa !37
  %72 = getelementptr inbounds float, float* %data, i64 28
  %73 = bitcast float* %72 to i32*
  store i32 %71, i32* %73, align 4, !tbaa !37
  %74 = getelementptr inbounds [32 x float], [32 x float]* %privateFloats, i64 0, i64 30
  %75 = bitcast float* %74 to i32*
  %76 = load i32, i32* %75, align 4, !tbaa !37
  %77 = getelementptr inbounds float, float* %data, i64 30
  %78 = bitcast float* %77 to i32*
  store i32 %76, i32* %78, align 4, !tbaa !37
  call void @llvm.lifetime.end(i64 128, i8* %0) #8
  ret void
}

; Function Attrs: norecurse nounwind readnone
define %struct.float4 @_Z9getfloat4f(float %a) #1 {
  %1 = fadd float %a, 1.000000e+00
  %2 = fadd float %a, 2.500000e+00
  %3 = insertvalue %struct.float4 undef, float %a, 0
  %4 = insertvalue %struct.float4 %3, float %1, 1
  %5 = insertvalue %struct.float4 %4, float %2, 2
  ret %struct.float4 %5
}

; Function Attrs: norecurse nounwind readnone
define float @_Z19getfloat4ElementSumfii(float %a, i32 %e0, i32 %e1) #1 {
  %res = alloca %struct.float4, align 16
  %1 = bitcast %struct.float4* %res to i8*
  call void @llvm.lifetime.start(i64 16, i8* %1) #8
  %2 = fadd float %a, 1.000000e+00
  %3 = fadd float %a, 2.500000e+00
  %4 = getelementptr inbounds %struct.float4, %struct.float4* %res, i64 0, i32 0
  store float %a, float* %4, align 16
  %5 = getelementptr inbounds %struct.float4, %struct.float4* %res, i64 0, i32 1
  store float %2, float* %5, align 4
  %6 = getelementptr inbounds %struct.float4, %struct.float4* %res, i64 0, i32 2
  store float %3, float* %6, align 8
  %7 = sext i32 %e0 to i64
  %8 = getelementptr inbounds float, float* %4, i64 %7
  %9 = load float, float* %8, align 4, !tbaa !37
  %10 = fadd float %9, 0.000000e+00
  %11 = sext i32 %e1 to i64
  %12 = getelementptr inbounds float, float* %4, i64 %11
  %13 = load float, float* %12, align 4, !tbaa !37
  %14 = fadd float %10, %13
  call void @llvm.lifetime.end(i64 16, i8* %1) #8
  ret float %14
}

; Function Attrs: norecurse nounwind
define void @_Z22testFloat4_insertvalueP6float4Pfi(%struct.float4* nocapture %data, float* nocapture readonly %data2, i32 %N) #2 {
  %1 = load float, float* %data2, align 4, !tbaa !37
  %2 = fadd float %1, 1.000000e+00
  %3 = fadd float %1, 2.500000e+00
  %4 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 0, i32 0
  store float %1, float* %4, align 16
  %5 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 0, i32 1
  store float %2, float* %5, align 4
  %6 = getelementptr inbounds %struct.float4, %struct.float4* %data, i64 0, i32 2
  store float %3, float* %6, align 8
  ret void
}

; Function Attrs: norecurse nounwind
define void @_Z11useHasArrayP8hasArray(%struct.hasArray* nocapture %data) #2 {
  %1 = getelementptr inbounds %struct.hasArray, %struct.hasArray* %data, i64 1, i32 0, i64 2
  %2 = load i32, i32* %1, align 4, !tbaa !41
  %3 = getelementptr inbounds %struct.hasArray, %struct.hasArray* %data, i64 0, i32 0, i64 0
  store i32 %2, i32* %3, align 4, !tbaa !41
  ret void
}

; Function Attrs: nounwind readnone
declare i32 @llvm.ptx.read.tid.x() #6

; Function Attrs: nounwind readnone
declare i32 @llvm.ptx.read.ctaid.x() #6

; Function Attrs: nounwind readnone
declare i32 @llvm.ptx.read.nctaid.x() #6

; Function Attrs: nounwind readnone
declare i32 @llvm.ptx.read.ntid.x() #6

; Function Attrs: noduplicate nounwind
declare void @llvm.cuda.syncthreads() #7

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_20" "target-features"="+ptx42" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { norecurse nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_20" "target-features"="+ptx42" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_20" "target-features"="+ptx42" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_20" "target-features"="+ptx42" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { norecurse nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="sm_20" "target-features"="+ptx42" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone }
attributes #7 = { noduplicate nounwind }
attributes #8 = { nounwind }

!nvvm.annotations = !{!0, !1, !2, !3, !4, !5, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !31, !33, !33, !33, !33, !34, !34, !33}
!llvm.ident = !{!35}
!nvvm.internalize.after.link = !{}
!nvvmir.version = !{!36}

!0 = !{void (float*)* @_Z3fooPf, !"kernel", i32 1}
!1 = !{void (float*)* @_Z7use_tidPf, !"kernel", i32 1}
!2 = !{void (i32*)* @_Z8use_tid2Pi, !"kernel", i32 1}
!3 = !{void (float*)* @_Z10copy_floatPf, !"kernel", i32 1}
!4 = !{void (float*)* @_Z11use_blockidPf, !"kernel", i32 1}
!5 = !{void (float*)* @_Z11use_griddimPf, !"kernel", i32 1}
!6 = !{void (float*)* @_Z12use_blockdimPf, !"kernel", i32 1}
!7 = !{void (float*, i32*)* @_Z13use_template1PfPi, !"kernel", i32 1}
!8 = !{void (float*)* @_Z13someops_floatPf, !"kernel", i32 1}
!9 = !{void (i32*)* @_Z11someops_intPi, !"kernel", i32 1}
!10 = !{void (i32*)* @_Z14testbooleanopsPi, !"kernel", i32 1}
!11 = !{void (i32*)* @_Z26testcomparisons_int_signedPi, !"kernel", i32 1}
!12 = !{void (float*)* @_Z21testcomparisons_floatPf, !"kernel", i32 1}
!13 = !{void (float*)* @_Z15testsyncthreadsPf, !"kernel", i32 1}
!14 = !{void (i32*, i32)* @_Z11testDoWhilePii, !"kernel", i32 1}
!15 = !{void (i32*, i32)* @_Z9testWhilePii, !"kernel", i32 1}
!16 = !{void (i32*, i32)* @_Z6testIfPii, !"kernel", i32 1}
!17 = !{void (i32*, i32)* @_Z10testIfElsePii, !"kernel", i32 1}
!18 = !{void (float*)* @_Z11testTernaryPf, !"kernel", i32 1}
!19 = !{void (float*, i32)* @_Z7testForPfi, !"kernel", i32 1}
!20 = !{void (float*, i32, float)* @_Z8setValuePfif, !"kernel", i32 1}
!21 = !{void (%struct.MyStruct*, float*, i32*)* @_Z11testStructsP8MyStructPfPi, !"kernel", i32 1}
!22 = !{void (%struct.float4*)* @_Z10testFloat4P6float4, !"kernel", i32 1}
!23 = !{void (%struct.float4*)* @_Z16testFloat4_test2P6float4, !"kernel", i32 1}
!24 = !{void (%struct.float4*)* @_Z16testFloat4_test3P6float4, !"kernel", i32 1}
!25 = !{void (float*)* @_Z9testLocalPf, !"kernel", i32 1}
!26 = !{void (float*)* @_Z10testLocal2Pf, !"kernel", i32 1}
!27 = !{void (float*)* @_Z9testArrayPf, !"kernel", i32 1}
!28 = !{void (float*)* @_Z10testmemcpyPf, !"kernel", i32 1}
!29 = !{void (%struct.float4*, float*, i32)* @_Z22testFloat4_insertvalueP6float4Pfi, !"kernel", i32 1}
!30 = !{void (%struct.hasArray*)* @_Z11useHasArrayP8hasArray, !"kernel", i32 1}
!31 = !{null, !"align", i32 8}
!32 = !{null, !"align", i32 8, !"align", i32 65544, !"align", i32 131080}
!33 = !{null, !"align", i32 16}
!34 = !{null, !"align", i32 16, !"align", i32 65552, !"align", i32 131088}
!35 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
!36 = !{i32 1, i32 2}
!37 = !{!38, !38, i64 0}
!38 = !{!"float", !39, i64 0}
!39 = !{!"omnipotent char", !40, i64 0}
!40 = !{!"Simple C/C++ TBAA"}
!41 = !{!42, !42, i64 0}
!42 = !{!"int", !39, i64 0}
!43 = distinct !{!43, !44}
!44 = !{!"llvm.loop.unroll.disable"}
!45 = !{!46, !42, i64 0}
!46 = !{!"_ZTS8MyStruct", !42, i64 0, !38, i64 4}
!47 = !{!46, !38, i64 4}
!48 = !{i64 0, i64 4, !37, i64 4, i64 4, !37, i64 8, i64 4, !37, i64 12, i64 4, !37}