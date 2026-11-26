use crate::{geometry::THREADS_PER_WARP, thread::Thread};

pub enum SplitResult {
    AllTaking(Path),
    AllPassing(Path),
    Divergence{taking: Path, passing: Path}
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Path {
    pub threads: Vec<Box<Thread>>,
    pub pc: u32,
}

impl Path {
    pub fn empty(pc: u32) -> Self {
        let tvec = Vec::with_capacity(THREADS_PER_WARP);
        Path {
            threads: tvec,
            pc
        }
    }

    pub fn new(pc: u32, mut threads: Vec<Box<Thread>>) -> Self {
        threads.reserve_exact(THREADS_PER_WARP - threads.len());
        Path {
            threads,
            pc
        }
    }

    pub fn split(mut self, predicate: impl Fn(&Thread) -> bool) -> SplitResult {
        let (takers, passers) = 
            self.threads.drain(..).partition::<Vec<_>, _>(|t | predicate(t));

        use SplitResult::*;
        match (takers.is_empty(), passers.is_empty()) {
            (true, true) => unreachable!(), // This is impossible: the active path has at least one thread, and every thread either takes or passes the branch.
            (true, false) => AllPassing(Self::new(self.pc, passers)), // All threads pass the branch, so the active path continues.
            (false, true) => AllTaking(Self::new(self.pc, takers)), // All threads take the branch, so the active path continues.
            (false, false) => Divergence { taking: Self::new(self.pc, takers), passing: Self::new(self.pc, passers) } // Branch divergence
        }
    }

    pub fn leader_id(&self) -> usize {
        // TODO: Determine the leader selection policy.
        //       For now, just pick the thread with the lowest ID.
        let mut lowest_id = usize::MAX;
        for t in &self.threads {
            if t.thread_id < lowest_id {
                lowest_id = t.thread_id;
            }
        }
        debug_assert!(self.thread(lowest_id).is_some(), "Path::leader_id(&self) has returned a thread ID not found in the path!");
        lowest_id
    }

    pub fn leader(&self) -> &Thread {
        self.thread(self.leader_id()).unwrap()
    }

    pub fn leader_mut(&mut self) -> &mut Thread {
        self.thread_mut(self.leader_id()).unwrap()
    }

    pub fn has_thread(&self, thread_id: usize) -> bool {
        self.thread(thread_id).is_some()
    }

    pub fn thread(&self, thread_id: usize) -> Option<&Thread> {
        for t in &self.threads {
            if t.thread_id == thread_id {
                return Some(t);
            }
        }
        None
    }

    pub fn thread_mut(&mut self, thread_id: usize) -> Option<&mut Thread> {
        for t in &mut self.threads {
            if t.thread_id == thread_id {
                return Some(t);
            }
        }
        None
    }

    pub fn threads(&self) -> impl Iterator<Item = &Thread> {
        self.threads.iter().map(|t| Box::as_ref(t))
    }

    pub fn threads_mut(&mut self) -> impl Iterator<Item = &mut Thread> {
        self.threads.iter_mut().map(|t| Box::as_mut(t))
    }
}