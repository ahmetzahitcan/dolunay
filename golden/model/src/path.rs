use crate::{geometry::{INITIAL_PC, THREADS_PER_WARP}, thread::Thread};

/// A path's number within its warp.
type PathId = u8;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct PathManager {
    threads: [Thread; THREADS_PER_WARP],
    paths: [PathId; THREADS_PER_WARP],
    pc_storage: [u32; THREADS_PER_WARP],
    active_path: PathId,

    // The pc of the active path.
    pub pc: u32,
}

impl PathManager {
    pub fn new(warp_id: u16) -> PathManager {
        PathManager {
            threads: std::array::from_fn(|i| Thread::new(warp_id, i as u16)),
            paths: [0; THREADS_PER_WARP],
            pc_storage: [INITIAL_PC; THREADS_PER_WARP],
            active_path: 0,
            pc: INITIAL_PC,
        }
    }

    pub fn split(&mut self, predicate: impl Fn(&Thread) -> bool, taking_pc: u32, passing_pc: u32) -> (Option<PathId>, Option<PathId>) {
        let (takers, passers) = 
            self.active().partition::<Vec<_>, _>(|t | predicate(*t));

        match (takers.is_empty(), passers.is_empty()) {
            (true, true) => unreachable!(), // This is impossible: the active path has at least one thread, and every thread either takes or passes the branch.
            (true, false) => {
                // All threads pass the branch, so the active path continues.
                self.pc = passing_pc;
                (None, Some(self.active_path))
            }, 
            (false, true) => {
                // All threads take the branch, so the active path continues.
                self.pc = taking_pc;
                (Some(self.active_path), None)
            },  
            (false, false) => {
                // Branch divergence

                todo!()
            }
        }
    }

    pub fn switch(&mut self, new_path: PathId) {
        self.pc_storage[self.active_path as usize] = self.pc;
        self.active_path = new_path;
        self.pc = self.pc_storage[new_path as usize];
    }

    /// The threads on `path`, or every thread when `path` is `None`.
    fn on_path(&self, path: Option<PathId>) -> impl Iterator<Item = &Thread> {
        self.threads
            .iter()
            .zip(self.paths)
            .filter(move |&(_, p)| path.is_none_or(|path| p == path))
            .map(|(thread, _)| thread)
    }

    /// The threads on `path`, or every thread when `path` is `None`.
    fn on_path_mut(&mut self, path: Option<PathId>) -> impl Iterator<Item = &mut Thread> {
        self.threads
            .iter_mut()
            .zip(self.paths)
            .filter(move |&(_, p)| path.is_none_or(|path| p == path))
            .map(|(thread, _)| thread)
    }

    /// All threads, in thread order.
    pub fn all(&self) -> impl Iterator<Item = &Thread> {
        self.on_path(None)
    }

    /// All threads, in thread order.
    pub fn all_mut(&mut self) -> impl Iterator<Item = &mut Thread> {
        self.on_path_mut(None)
    }

    /// The IDs of all threads, in thread order.
    pub fn all_ids(&self) -> impl Iterator<Item = usize> {
        0..THREADS_PER_WARP
    }

    /// The active path's threads, in thread order.
    pub fn active(&self) -> impl Iterator<Item = &Thread> {
        self.on_path(Some(self.active_path))
    }

    /// The active path's threads, in thread order.
    pub fn active_mut(&mut self) -> impl Iterator<Item = &mut Thread> {
        self.on_path_mut(Some(self.active_path))
    }

    /// The IDs of the active path's threads, in thread order.
    pub fn active_ids(&self) -> impl Iterator<Item = usize> {
        (0..THREADS_PER_WARP).filter(|&i| self.paths[i] == self.active_path)
    }

    /// The threads on the same path as `thread_id`, in thread order.
    pub fn friends(&self, thread_id: u16) -> impl Iterator<Item = &Thread> {
        self.on_path(Some(self.paths[thread_id as usize]))
    }

    /// The threads on the same path as `thread_id`, in thread order.
    pub fn friends_mut(&mut self, thread_id: u16) -> impl Iterator<Item = &mut Thread> {
        self.on_path_mut(Some(self.paths[thread_id as usize]))
    }

    /// The IDs of the threads on the same path as `thread_id`, in thread order.
    pub fn friends_ids(&self, thread_id: u16) -> impl Iterator<Item = usize> {
        let path = self.paths[thread_id as usize];
        (0..THREADS_PER_WARP).filter(move |&i| self.paths[i] == path)
    }

    pub fn thread(&self, thread_id: u16) -> &Thread {
        &self.threads[thread_id as usize]
    }

    pub fn thread_mut(&mut self, thread_id: u16) -> &mut Thread {
        &mut self.threads[thread_id as usize]
    }
}